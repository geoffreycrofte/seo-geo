# SEO notes

Project-specific SEO and GEO decisions. They override the generic advice of the
`seo-geo` skill. Update this file after every SEO change.

_Last updated: YYYY-MM-DD_

## Stack

- Framework / CMS:
- Hosting (redirect support? 301 or meta refresh):
- Languages and URL scheme (e.g. `/` = en, `/fr/` = fr):
- Trailing-slash convention:

## Where each element is generated

| Element | File / function |
| --- | --- |
| `<title>`, meta description | |
| Canonical, `hreflang` | |
| Open Graph, default image | |
| JSON-LD | |
| Sitemap | |
| `robots.txt` | |
| `llms.txt` | |
| IndexNow submission | |

## Decisions

- AI crawler policy (allow all / refuse training, stay citable): … — decided by …, on YYYY-MM-DD.
- Search Console property type and verification method:
- Other:

## Content constraints

- Tone, audience, reading level:
- Affiliate policy and disclosure wording:
- Author(s) and their `sameAs` profiles:

## Topic map

```text
/                        (home)
├── /pillar/             (pillar: "…")
│   ├── /pillar/child-a/
│   └── /pillar/child-b/   ← gap: "…" not written yet
└── …
```

## Accepted audit exceptions

Findings from `scripts/audit.sh` that are known and intended, so they are not reported again.

- e.g. `/404.html`: no canonical (intended).
