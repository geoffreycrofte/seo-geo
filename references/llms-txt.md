# llms.txt

`llms.txt` ([llmstxt.org](https://llmstxt.org/), proposed by Jeremy Howard in 2024) is a Markdown file at the site root that introduces the site and lists its key pages for language models.

**Set expectations honestly**: adoption is uneven, and Google has said it does not use it for ranking. It is cheap, and it can help assistants and agents that read it. It does not replace a sitemap or good content.

## Format

```markdown
# Site name

> One-paragraph summary: who you are, what the site offers, for whom, in which languages.

Optional short notes (where to buy, licence, contact).

## Guides
- [Page title](https://example.com/page/): one-line description.

## Optional
- [Blog](https://example.com/blog/): what a model can skip when short on context.
```

- One `h1` (the site name), then a `>` summary, then `h2` sections with lists of links in the form `[title](url): description`.
- `## Optional` holds what can be skipped.
- A ready-to-adapt file is in [../assets/llms.txt](../assets/llms.txt).

## Rules

- **Generate it at build time** from the content collections or CMS, never by hand, so it stays in sync.
- List canonical URLs only, in the same language as the section, and reuse the pages' meta descriptions as the one-line descriptions.
- Optional `llms-full.txt`: the full text of the key pages in Markdown. Keep it to evergreen content.
