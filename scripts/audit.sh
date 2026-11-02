#!/usr/bin/env bash
# SEO / GEO audit of a static build folder.
#
# Usage: bash scripts/audit.sh <build-dir> [--strict]
#   <build-dir>  folder holding the generated HTML (dist, public, _site, out…)
#   --strict     exit with status 1 when at least one issue is found (for CI)
#
# Needs only bash, find, grep, sed, sort and uniq. Read-only: it never
# modifies the build folder. The checks are heuristics on the HTML text, not
# a full parser: review the findings before acting on them.

set -uo pipefail

usage() { sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'; }

OUT=""
STRICT=0
for arg in "$@"; do
  case "$arg" in
    --strict) STRICT=1 ;;
    -h|--help) usage; exit 0 ;;
    -*) echo "Unknown option: $arg" >&2; usage >&2; exit 2 ;;
    *) OUT="${arg%/}" ;;
  esac
done

if [ -z "$OUT" ]; then usage >&2; exit 2; fi
if [ ! -d "$OUT" ]; then
  echo "Error: '$OUT' is not a directory. Build the site first, then pass its output folder." >&2
  exit 2
fi

ISSUES=0
issue() { printf '  - %s\n' "$1"; ISSUES=$((ISSUES + 1)); }
section() { printf '\n## %s\n' "$1"; }

PAGES=()
while IFS= read -r -d '' f; do PAGES+=("$f"); done \
  < <(find "$OUT" -type f -name '*.html' -print0 | sort -z)

if [ "${#PAGES[@]}" -eq 0 ]; then
  echo "Error: no .html files found under '$OUT'." >&2
  exit 2
fi

# Collapse a page to one line so tags spread over several lines still match.
flat() { tr '\n\r' '  ' < "$1"; }
rel() { printf '%s' "${1#"$OUT"}"; }

MULTILINGUAL=0
if grep -rqil --include='*.html' 'hreflang=' "$OUT"; then MULTILINGUAL=1; fi

printf '# SEO audit of %s (%d pages%s)\n' "$OUT" "${#PAGES[@]}" \
  "$([ $MULTILINGUAL -eq 1 ] && echo ', multilingual')"

section "Head and structure, per page"
TITLES=$(mktemp); DESCS=$(mktemp)
trap 'rm -f "$TITLES" "$DESCS"' EXIT
for f in "${PAGES[@]}"; do
  page=$(flat "$f")
  p=$(rel "$f")
  # Redirect stubs (meta refresh) are not real pages.
  if grep -qiE '<meta[^>]+http-equiv=["'\'']?refresh' <<<"$page"; then continue; fi

  title=$(grep -oiE '<title[^>]*>[^<]*' <<<"$page" | head -1 | sed -E 's/<title[^>]*>//I;s/^ +| +$//g')
  if [ -z "$title" ]; then issue "no <title>: $p"; else
    printf '%s\t%s\n' "$title" "$p" >> "$TITLES"
    len=${#title}
    if [ "$len" -gt 65 ]; then issue "title too long ($len chars): $p"; fi
    if [ "$len" -lt 20 ]; then issue "title very short ($len chars): $p"; fi
  fi

  desc=$(grep -oiE '<meta[^>]+name=["'\'']?description["'\'']?[^>]*>' <<<"$page" | head -1 \
    | grep -oiE 'content="[^"]*"' | sed -E 's/^content="//I;s/"$//')
  if [ -z "$desc" ]; then issue "no meta description: $p"; else
    printf '%s\t%s\n' "$desc" "$p" >> "$DESCS"
    len=${#desc}
    if [ "$len" -gt 170 ]; then issue "description too long ($len chars): $p"; fi
    if [ "$len" -lt 70 ]; then issue "description very short ($len chars): $p"; fi
  fi

  grep -qiE '<link[^>]+rel=["'\'']?canonical' <<<"$page" || issue "no canonical: $p"
  grep -qiE '<html[^>]+lang=' <<<"$page" || issue "no <html lang>: $p"

  h1=$(grep -oiE '<h1[ >]' <<<"$page" | wc -l | tr -d ' ')
  if [ "$h1" -eq 0 ]; then issue "no h1: $p"; elif [ "$h1" -gt 1 ]; then issue "$h1 h1 elements: $p"; fi

  if [ $MULTILINGUAL -eq 1 ]; then
    grep -qi 'hreflang=' <<<"$page" || issue "no hreflang on a multilingual site: $p"
    grep -qi 'hreflang=["'\'']\{0,1\}x-default' <<<"$page" || issue "no hreflang x-default: $p"
  fi

  grep -qiE 'property=["'\'']?og:image' <<<"$page" || issue "no og:image: $p"

  if grep -qiE '<meta[^>]+name=["'\'']?robots["'\'']?[^>]+noindex' <<<"$page"; then
    printf '  - info: noindex (check it is intended): %s\n' "$p"
  fi

  missing_alt=$(grep -oiE '<img[^>]*>' <<<"$page" | grep -viE '[[:space:]]alt([[:space:]]*=|[[:space:]]|/?>)' | wc -l | tr -d ' ')
  if [ "$missing_alt" -gt 0 ]; then issue "$missing_alt <img> without alt: $p"; fi
done

section "Duplicates"
dup() {
  cut -f1 "$1" | sort | uniq -d | while IFS= read -r v; do
    issue "duplicate $2 \"$v\" on: $(awk -F'\t' -v v="$v" '$1==v{printf "%s ", $2}' "$1")"
  done
}
# Count in the current shell (the while loop above runs in a subshell).
before=$ISSUES
dups=$(dup "$TITLES" title; dup "$DESCS" description)
if [ -n "$dups" ]; then
  printf '%s\n' "$dups"
  ISSUES=$((before + $(printf '%s\n' "$dups" | wc -l)))
fi
[ $MULTILINGUAL -eq 1 ] && [ -n "$dups" ] && printf '  (the same title on language versions linked by hreflang is acceptable)\n'

section "Broken root-relative internal links"
broken=0
while IFS= read -r href; do
  path=${href%%[?#]*}
  [ -z "$path" ] && continue
  if [ -e "$OUT$path" ] || [ -e "$OUT${path%/}/index.html" ] || [ -e "$OUT$path.html" ]; then continue; fi
  issue "broken: $path"; broken=$((broken + 1))
done < <(for f in "${PAGES[@]}"; do flat "$f" | grep -oiE 'href="/[^/"][^"]*"|href="/"' ; done \
  | sed -E 's/^href="//I;s/"$//' | sort -u)
[ $broken -eq 0 ] && echo "  none"

section "Site files"
[ -f "$OUT/robots.txt" ] || issue "no robots.txt"
if [ -f "$OUT/robots.txt" ] && ! grep -qi '^sitemap:' "$OUT/robots.txt"; then issue "robots.txt does not reference a sitemap"; fi
ls "$OUT"/sitemap*.xml >/dev/null 2>&1 || issue "no sitemap*.xml at the root"
[ -f "$OUT/llms.txt" ] || printf '  - info: no llms.txt (optional, see references/llms-txt.md)\n'

printf '\n%d issue(s) found.\n' "$ISSUES"
printf 'Next: the manual checks in references/audit.md (Lighthouse, axe, structured data, social preview, AI visibility).\n'

if [ $STRICT -eq 1 ] && [ $ISSUES -gt 0 ]; then exit 1; fi
exit 0
