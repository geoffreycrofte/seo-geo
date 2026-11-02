# Technical SEO

Details behind the checklist in `SKILL.md` §2.

## Contents

- [Every page](#every-page)
- [Multilingual sites](#multilingual-sites)
- [Discovery: sitemaps, Search Console, IndexNow](#discovery-sitemaps-search-console-indexnow)

## Every page

- **Title** `<title>`: unique, about 50–60 characters (cut at about 600 px in results). Main topic first, then the brand: `Topic · Brand`.
- **Meta description**: unique, about 120–160 characters. A promise of what the page answers, not a keyword list. It is also the default social description.
- **Canonical**: absolute URL, self-referencing, with the site's trailing-slash convention applied consistently everywhere (links, sitemap, canonical).
- **Indexing**: `noindex` only on pages that must stay out (search results, thank-you pages, drafts). Never block in `robots.txt` a page you want deindexed: the crawler cannot see the `noindex`.
- **Headings**: one `h1`, then `h2` and `h3` without skipping levels. They form the outline that both readers and models use.
- **Language**: `<html lang>` correct on every page.
- **URLs**: short, lowercase, hyphenated, readable, translated on multilingual sites. **Never change a published URL without a redirect**: use a 301 on servers that support it, or a `meta refresh` page with a canonical to the new URL on static hosts without redirects.
- **Images**: descriptive `alt` (or `alt=""` when decorative), explicit `width` and `height`, modern formats, lazy-loading below the fold, and no important information only inside an image.
- **Performance**: Core Web Vitals at the 75th percentile: LCP ≤ 2.5 s, INP ≤ 200 ms, CLS ≤ 0.1. Self-host fonts, keep third-party scripts to a minimum, compress images in the build or in CI.

Minimal `<head>` for an article:

```html
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Choosing a burr grinder · Example Coffee</title>
  <meta name="description" content="How to pick a burr grinder for espresso: burr types, grind range and the three models I tested for a year.">
  <link rel="canonical" href="https://example.com/guides/burr-grinder/">
  <link rel="alternate" hreflang="en" href="https://example.com/guides/burr-grinder/">
  <link rel="alternate" hreflang="fr" href="https://example.com/fr/guides/moulin-a-meules/">
  <link rel="alternate" hreflang="x-default" href="https://example.com/guides/burr-grinder/">
  <!-- Open Graph: see open-graph.md; JSON-LD: see structured-data.md -->
</head>
```

## Multilingual sites

- One URL per language, never language switching by cookie or IP alone.
- `hreflang` on every version, listing all the versions **including itself**, plus `x-default`. The links must be reciprocal, otherwise they are ignored.
- Translate slugs, titles and descriptions, and adapt the content rather than translating it word for word. Point internal links to the same-language versions, and say so when a destination exists only in another language.
- Make the build fail when a translation is missing, so the language versions never go out of step.

## Discovery: sitemaps, Search Console, IndexNow

- **XML sitemap**: only canonical, indexable URLs, with `hreflang` alternates when relevant. Referenced in `robots.txt` and submitted in Google Search Console and Bing Webmaster Tools. A sitemap index that points to sub-sitemaps is normal.
- **Search Console**: prefer a *Domain* property, verified by a DNS TXT record at the apex. A subdomain that is a CNAME cannot hold a TXT record, so use the apex or an HTML-file or meta-tag verification instead.
- **IndexNow** (Bing, Yandex, Seznam, Naver…): host a key file `/<key>.txt` whose content is the key, then POST changed URLs to `https://api.indexnow.org/indexnow`. On static sites, hash the built pages, compare them with the live manifest, and submit only new or changed URLs **after** the deploy. A submission error must never block a deploy.
- **Bing Webmaster Tools** can import a Search Console property without verifying the domain again.

IndexNow submission body:

```json
{
  "host": "example.com",
  "key": "<key>",
  "keyLocation": "https://example.com/<key>.txt",
  "urlList": ["https://example.com/guides/burr-grinder/"]
}
```
