# Changelog

All notable changes to this skill are documented here.
The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the skill uses [Semantic Versioning](https://semver.org/):
**major** for a change in scope or a breaking change in the workflow, **minor** for new guidance, references or tools, **patch** for corrections and refreshed facts.

## [Unreleased]

### Added

- Licence: CC BY 4.0 (`LICENSE`, `license` in `SKILL.md` and `plugin.json`).

## [1.1.0] - 2026-11-02

### Added

- `references/` folder for progressive disclosure: `technical-seo.md`, `structured-data.md`, `ai-crawlers.md`, `llms-txt.md`, `open-graph.md`, `audit.md`, `staying-current.md`. Claude loads each one only when the task needs it.
- `scripts/audit.sh`: a runnable audit of a static build (titles, descriptions, canonical, `lang`, `h1`, `hreflang`, `og:image`, `alt`, duplicates, broken internal links, `robots.txt`, sitemap, `llms.txt`), with a `--strict` mode for CI.
- `assets/`: templates for the project's `docs/seo.md`, `robots.txt` and `llms.txt`.
- Examples: a full article `<head>`, a JSON-LD `@graph` with stable `@id`s, an Open Graph block, a topic-map tree, an IndexNow payload, a quotable passage.
- AI crawler table by vendor and role (training, search, user-initiated fetch), including `ChatGPT-User` and `Perplexity-User`.
- "Report back" section: what Claude tells the user at the end of a task.
- Claude Code plugin and marketplace manifests (`.claude-plugin/`), so the skill installs with `/plugin`.
- Eval suite (`evals/`) for `claude plugin eval`: three triggering-and-quality cases and one should-not-trigger case.
- `README.md`, `CHANGELOG.md`.

### Changed

- `SKILL.md` is now a lean entry point (workflow, checklist, content, structure, GEO) with a "where to find what" table; detailed material moved to `references/`.
- The review date moved to the frontmatter (`metadata.last-reviewed`), next to `metadata.version`.
- `ClaudeBot` added to the list of training crawlers to block in the "refuse training, stay citable" policy.

## [1.0.0] - 2026-11-02

### Added

- First version of the `seo-geo` skill: workflow, technical foundations, multilingual sites, discovery (sitemaps, Search Console, IndexNow), content and E-E-A-T, semantic cocoon, GEO, `llms.txt`, AI crawlers, structured data, Open Graph, audit commands, and how to stay current.

[Unreleased]: https://github.com/geoffreycrofte/seo-geo/compare/v1.1.0...HEAD
[1.1.0]: https://github.com/geoffreycrofte/seo-geo/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/geoffreycrofte/seo-geo/releases/tag/v1.0.0
