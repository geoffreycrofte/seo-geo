---
name: seo-geo
description: Search engine optimisation (SEO) and generative engine optimisation (GEO, being cited by ChatGPT, Perplexity, Claude, Gemini and Google AI Overviews) for any website. Use when writing or reviewing a page, article or product page; choosing titles, meta descriptions, slugs or internal links; planning a topic cluster or semantic cocoon; setting up or checking canonical, hreflang, Open Graph, structured data (JSON-LD), sitemaps, robots.txt, llms.txt, IndexNow or AI crawler rules; or auditing a site's SEO and AI visibility.
license: CC-BY-4.0
metadata:
  author: Geoffrey Crofte
  version: "1.1.0"
  last-reviewed: "2026-11"
---

# SEO and GEO

Make a website findable in search engines and citable by generative engines, without trading away accessibility, performance or reader trust.

Guiding principle: **one page = one search intent = one clear, first-hand, sourced answer.** What serves readers serves Google, Bing and AI assistants.

## Where to find what

This file holds the workflow and the rules that apply to every task. Read a reference file only when the task touches its topic.

| Task touches… | Read |
| --- | --- |
| Titles, canonical, indexing, URLs, images, Core Web Vitals, hreflang, sitemaps, Search Console, IndexNow | [references/technical-seo.md](references/technical-seo.md) |
| JSON-LD, rich results | [references/structured-data.md](references/structured-data.md) |
| `robots.txt`, AI bots, training opt-out | [references/ai-crawlers.md](references/ai-crawlers.md) |
| `llms.txt`, `llms-full.txt` | [references/llms-txt.md](references/llms-txt.md) |
| Open Graph, social previews | [references/open-graph.md](references/open-graph.md) |
| Auditing a site | [references/audit.md](references/audit.md) and [scripts/audit.sh](scripts/audit.sh) |
| Checking for newer practices | [references/staying-current.md](references/staying-current.md) |

Templates to copy into a project: [assets/seo-notes-template.md](assets/seo-notes-template.md) (project notes), [assets/robots.txt](assets/robots.txt), [assets/llms.txt](assets/llms.txt).

## 0. Before you start

1. **Read the project's own SEO notes** if they exist: `docs/seo.md`, a `## SEO` section in `CLAUDE.md` or `README.md`. They record what is already in place (where the head tags, JSON-LD and sitemap live), the site's topic map and its constraints. **Project notes override the generic advice in this skill.**
2. **No notes yet?** Run the audit (§6) first, then create `docs/seo.md` from [assets/seo-notes-template.md](assets/seo-notes-template.md). Keep it updated after each change.
3. **Check for newer practices** ([references/staying-current.md](references/staying-current.md)) when the work is more than a small edit, or when `last-reviewed` in this file's frontmatter is more than about six months old.

## 1. Workflow

1. **Audit**: what exists, what is missing, what is broken (§6).
2. **Plan**: rank the fixes by impact. In order: indexability and crawl errors first, then duplicate or missing titles and descriptions, then internal linking and structure, then content gaps, then enhancements (structured data, llms.txt, social).
3. **Implement**: generate SEO elements from data (layouts, content schemas, build scripts) instead of writing them by hand on each page, so they never drift.
4. **Verify**: build, rerun the audit, check one page of each type in the browser, test the social preview, validate the structured data.
5. **Record**: update the project notes and the topic map.

## 2. Technical checklist (every page)

Details, thresholds and edge cases: [references/technical-seo.md](references/technical-seo.md).

- [ ] Unique `<title>` (~50–60 characters, `Topic · Brand`) and meta description (~120–160 characters, a promise, not a keyword list).
- [ ] Absolute, self-referencing canonical, with one trailing-slash convention everywhere.
- [ ] `noindex` only where intended, and never on a URL that `robots.txt` blocks.
- [ ] One `h1`, then `h2`/`h3` without skipping levels; correct `<html lang>`.
- [ ] Short, readable URLs. **Never change a published URL without a redirect.**
- [ ] Images with meaningful `alt` (or `alt=""`), `width`/`height`, modern formats, lazy-loading below the fold.
- [ ] Core Web Vitals at p75: LCP ≤ 2.5 s, INP ≤ 200 ms, CLS ≤ 0.1.
- [ ] Multilingual: one URL per language, reciprocal `hreflang` including self and `x-default`.
- [ ] Sitemap with only canonical, indexable URLs, referenced in `robots.txt`.

**Accessibility overlaps SEO**: descriptive link text, a sound heading structure, alt text and a valid `lang` help both. Never sacrifice WCAG for an SEO trick.

## 3. Content that ranks and gets cited

- **Search intent first**: write down the question the page answers before writing it. Check that no other page already answers it, to avoid cannibalisation.
- **E-E-A-T**: show first-hand Experience (tests, mistakes, photos, measurements, "I have used this since…", "I have not tested this one"), Expertise, Authoritativeness (consistent author identity, links from and to recognised sources) and Trust (transparency on affiliate links, accurate dates, contact details).
- **Answer first**: the first sentence under each heading answers that heading on its own, in one to three lines. Details come after.
- **Precision**: real numbers with their units (and the common conversions), named brands, models and standards. Cite the source when a figure is not from your own practice.
- **Useful formats**: comparison tables, step-by-step lists, short definitions, FAQ blocks built from real reader questions.
- **Freshness**: show publication and update dates, and update `dateModified` only for substantial changes.
- **Affiliate links**: `rel="sponsored"` on each one, a visible disclosure near the top of the page, and real first-hand content around them.
- **Do not**: produce mass AI or paraphrased content without first-hand input, near-duplicate pages that change only a keyword, keyword stuffing, hidden text or links, fake reviews.

## 4. Site structure: topic clusters and the semantic cocoon

The semantic cocoon (a method formalised by Laurent Bourrelly), like topic clusters, organises pages as a tree: a **parent page** covers a broad topic, and each **child page** covers one precise intent. Links follow the tree, which gives meaning to search engines and a path to readers.

- **Up**: every child links to its parent, with an anchor that names the parent's topic.
- **Down**: the parent links to each child, with an anchor that names the child's intent.
- **Sideways**: siblings link to each other when the reader needs it ("next, read…"), not through generic sitewide blocks.
- **Across clusters**: go through the parent or the pillar page, except when the intent really justifies a direct link.
- **Anchors**: descriptive and varied; never "click here" or a bare URL.
- **Depth**: every important page is at most three clicks from the home page.
- **Orphans**: every page receives at least one contextual internal link.
- **Map**: keep an ASCII tree of the clusters in the project notes, and update it whenever a page is added. Use it to spot gaps, which are the next pieces of content to write.

```text
/guides/                      (pillar: "Home espresso")
├── /guides/grinders/         (parent: "Choosing a grinder")
│   ├── /guides/burr-vs-blade/
│   └── /guides/grind-size/
└── /guides/machines/         (parent: "Choosing a machine")
    └── /guides/single-boiler/   ← gap: "dual boiler" not written yet
```

## 5. Generative engine optimisation (GEO)

Generative engines retrieve short, self-contained passages and cite the sources that look reliable. In *GEO: Generative Engine Optimization* (Aggarwal et al., 2023), adding **source citations, statistics and quotations** raised visibility in generated answers the most, while keyword stuffing did not help.

- Write **quotable passages**: one clear sentence per definition or fact, which still makes sense if lifted out of the page.
- Use the **answer-first** structure, question-like headings and FAQ blocks.
- Keep **entities consistent**: the same spelling of the brand and author everywhere, matching the `Organization` and `Person` JSON-LD and `sameAs` profiles ([references/structured-data.md](references/structured-data.md)).
- Back claims with **sources and data**, and show **first-hand experience**, which models cannot invent.
- Make the content **available as text** in the HTML: not only in images or video, and not only rendered by client-side JavaScript.
- Check that **AI crawlers are allowed** ([references/ai-crawlers.md](references/ai-crawlers.md)), and offer an `llms.txt` ([references/llms-txt.md](references/llms-txt.md)).
- **Measure**: ask the main assistants the target questions, note whether and how the site is cited, and repeat after changes. AI referrals show up in analytics as `chatgpt.com`, `perplexity.ai` and similar.

Shape of a quotable, answer-first passage (placeholders in brackets; never invent the figures):

```markdown
## How long does a burr grinder last?

A burr grinder lasts [N] years with daily use; its burrs need replacing after
about [N] kg of coffee ([manufacturer], [year]).
I replaced mine after [N] years of daily use.
```

## 6. Audit

Run [scripts/audit.sh](scripts/audit.sh) on the built output (static sites), or crawl a staging URL (dynamic sites). The full procedure, including the manual checks the script cannot do, is in [references/audit.md](references/audit.md).

```bash
bash scripts/audit.sh dist          # add --strict to exit non-zero when issues are found
```

Record known, accepted exceptions in the project notes so they are not reported again.

## 7. Report back

When you finish, tell the user:

1. What you changed, grouped by the workflow order above.
2. What you found but did not change, ranked by impact, with the reason (out of scope, needs the owner's decision, needs data).
3. Any decision the owner must take (e.g. the AI crawler policy) and where it is recorded.
4. Any practice from this skill that looked outdated, with sources, as a **proposal** to update the skill. Do not edit the skill silently.
