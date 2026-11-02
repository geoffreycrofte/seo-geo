# Crawlers and AI bots

Bot names and their roles change: **check the vendors' documentation before editing `robots.txt`** (links in [staying-current.md](staying-current.md)).

## Main user agents

| Vendor | Training | Search / retrieval | Fetch on a user's request |
| --- | --- | --- | --- |
| OpenAI | `GPTBot` | `OAI-SearchBot` | `ChatGPT-User` |
| Anthropic | `ClaudeBot` | `Claude-SearchBot` | `Claude-User` |
| Perplexity | — | `PerplexityBot` | `Perplexity-User` |
| Google | `Google-Extended` (Gemini training; no effect on Google Search ranking) | `Googlebot` | — |
| Apple | `Applebot-Extended` | `Applebot` | — |
| Common Crawl | `CCBot` | — | — |
| Microsoft | — | `Bingbot` (also feeds Copilot) | — |

Fetchers acting on a user's request may not follow `robots.txt` the same way crawlers do; check each vendor's current policy.

## Policies

- **Allow by default** if the goal is to be cited.
- **Refuse model training but stay citable**: block the training bots (`GPTBot`, `ClaudeBot`, `Google-Extended`, `CCBot`, `Applebot-Extended`) and allow the search and retrieval bots (`OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`).
- This is **the owner's decision**: ask, then record it in the project notes.

## Example: refuse training, stay citable

A ready-to-copy version is in [../assets/robots.txt](../assets/robots.txt).

```text
# Training crawlers: blocked (owner's decision, recorded in docs/seo.md)
User-agent: GPTBot
User-agent: ClaudeBot
User-agent: Google-Extended
User-agent: CCBot
User-agent: Applebot-Extended
Disallow: /

# Everyone else, including search and AI retrieval bots
User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml
```

Grouping several `User-agent` lines over one rule set is valid per RFC 9309. Remember that `robots.txt` controls crawling, not indexing (see [technical-seo.md](technical-seo.md#every-page)).
