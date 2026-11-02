# Audit

## Contents

- [1. Automated checks](#1-automated-checks)
- [2. Manual checks](#2-manual-checks)
- [3. Report](#3-report)

## 1. Automated checks

Run them on the built output when possible.

- **Static sites**: run the bundled script on the build folder.

  ```bash
  bash scripts/audit.sh dist            # report only
  bash scripts/audit.sh dist --strict   # exit 1 when issues are found (CI)
  ```

  It reports: pages without a title, description, canonical, `lang` or `h1`; pages with several `h1`; duplicate titles and descriptions; images without `alt`; missing `hreflang` (when the site is multilingual); missing `og:image`; pages with `noindex`; broken root-relative internal links; and whether `robots.txt`, a sitemap and `llms.txt` exist.

- **Dynamic sites**: crawl a staging URL with a crawler such as Screaming Frog, or mirror it first (`wget --mirror --adjust-extension --no-parent https://staging.example.com/`) and run the script on the mirror.

Interpret the results with judgment: the same title on two language versions linked by `hreflang` is acceptable, and so is `alt=""` on a decorative image.

## 2. Manual checks

- Accessibility (axe) and Lighthouse on one page of each template.
- Structured data: [Rich Results Test](https://search.google.com/test/rich-results) and [Schema Markup Validator](https://validator.schema.org/) on one page of each type.
- Social preview: paste a link into a draft post, or use the platforms' debuggers.
- Google Search Console *Pages* and *Core Web Vitals* reports; Bing Webmaster Tools.
- Internal linking against the topic map (`SKILL.md` §4): orphans, depth, missing up/down links.
- AI visibility: ask the main assistants the site's core questions and note whether and how it is cited.

## 3. Report

Group the findings by the priority order of `SKILL.md` §1 (indexability first, enhancements last). For each: what, where (URL or template), why it matters, the fix. Record known, accepted exceptions in the project notes so they are not reported again.
