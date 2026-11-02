# SEO & GEO — an Agent Skill

An [Agent Skill](https://agentskills.io/) that teaches Claude (and other compatible agents) how to make a website **findable in search engines** and **citable by generative engines** (ChatGPT, Perplexity, Claude, Gemini, Google AI Overviews), without trading away accessibility, performance or reader trust.

> **One page = one search intent = one clear, first-hand, sourced answer.**

## What it does

Once installed, the skill activates on its own when a task touches SEO or GEO. No command to type: ask in plain words.

| Area | What Claude does with the skill |
| --- | --- |
| **Content** | Search intent first, answer-first writing, E-E-A-T, quotable passages, affiliate disclosure |
| **Site structure** | Topic clusters and semantic cocoon, internal linking up/down/sideways, a topic map kept in the project notes |
| **Technical SEO** | Titles, descriptions, canonical, `noindex`, headings, URLs and redirects, images, Core Web Vitals, `hreflang` |
| **Discovery** | XML sitemaps, Search Console, Bing Webmaster Tools, IndexNow after deploy |
| **GEO** | Quotable, sourced passages; consistent entities; AI crawler access; `llms.txt` |
| **Structured data** | JSON-LD `@graph` with stable `@id`s, current rich-result status |
| **Social** | Open Graph and Twitter cards, image specs |
| **Audit** | A runnable script for static builds, plus the manual checklist |
| **Staying current** | Checks primary sources when the guidance is older than six months, and proposes updates to the skill instead of editing it silently |

It also keeps **project memory**: it reads (or creates) `docs/seo.md` in your project, records decisions such as the AI crawler policy there, and lets those notes override its generic advice.

### Example prompts

- "Review the `<head>` of this product page and tell me what to fix."
- "Plan a topic cluster for our espresso guides and the internal links between them."
- "I don't want AI companies to train on my blog, but I want to be cited. What goes in robots.txt?"
- "Add an llms.txt generated from our Astro content collections."
- "Audit the `dist/` folder before we launch."

## Install

### Claude Code: as a plugin (recommended)

```text
/plugin marketplace add geoffreycrofte/seo-geo
/plugin install seo-geo@geoffreycrofte
```

Updates arrive with `/plugin marketplace update geoffreycrofte`.

### Claude Code: as a personal or project skill

```bash
# For you, in every project:
git clone https://github.com/geoffreycrofte/seo-geo.git ~/.claude/skills/seo-geo

# For one project, shared with the team through the repository:
git clone https://github.com/geoffreycrofte/seo-geo.git .claude/skills/seo-geo
```

### Claude.ai and the Claude desktop app

1. Download the zip: `git archive --prefix=seo-geo/ -o seo-geo.zip HEAD` (or GitHub's *Code → Download ZIP*, then rename the folder inside to `seo-geo`).
2. In **Settings → Capabilities → Skills**, upload the zip.

### Other agents

Any agent that supports the [Agent Skills format](https://agentskills.io/) can use the folder as is. With the [`skills` CLI](https://github.com/vercel-labs/skills):

```bash
npx skills add geoffreycrofte/seo-geo
```

## Contents

```text
seo-geo/
├── SKILL.md                    # Entry point: workflow, checklist, content, structure, GEO
├── references/                 # Loaded only when a task needs them
│   ├── technical-seo.md        #   titles, canonical, URLs, CWV, hreflang, sitemaps, IndexNow
│   ├── structured-data.md      #   JSON-LD rules and a full @graph example
│   ├── ai-crawlers.md          #   AI bots by vendor and role, robots.txt policies
│   ├── llms-txt.md             #   llms.txt format and rules
│   ├── open-graph.md           #   social sharing tags and image specs
│   ├── audit.md                #   automated and manual audit procedure
│   └── staying-current.md      #   primary sources and the update procedure
├── scripts/
│   └── audit.sh                # Audit of a static build: bash scripts/audit.sh dist [--strict]
├── assets/                     # Templates to copy into a project
│   ├── seo-notes-template.md   #   docs/seo.md
│   ├── robots.txt
│   └── llms.txt
├── evals/                      # Test cases for `claude plugin eval`
├── .claude-plugin/             # Claude Code plugin and marketplace manifests
├── CHANGELOG.md
└── README.md
```

`SKILL.md` stays short on purpose: Claude reads it whenever the skill activates, and opens a reference file only when the task touches that topic ([progressive disclosure](https://agentskills.io/specification#progressive-disclosure)).

### The audit script on its own

The script works without Claude. It needs only bash and the usual Unix tools, and never modifies the build:

```bash
bash scripts/audit.sh dist            # report
bash scripts/audit.sh dist --strict   # exit 1 when issues are found, for CI
```

## Development

### Test the skill

The `evals/` folder holds cases for [`claude plugin eval`](https://code.claude.com/docs/en/plugin-evals): realistic prompts that should trigger the skill (with a rubric for the answer) and one that should not. Each run calls the model on your account.

```bash
claude plugin validate .                  # manifests and paths
claude plugin eval . --ablation none      # quick run, with the skill only
claude plugin eval .                      # with and without the skill, to measure what it adds
```

### Contributing and updates

- Keep `SKILL.md` under about 200 lines; put detail in `references/`, one topic per file, linked directly from `SKILL.md`.
- Cite a primary source (Google, Bing, schema.org, vendor docs) for any new fact, and prefer dated sources.
- Bump `metadata.version` in `SKILL.md` and `version` in `.claude-plugin/plugin.json` together, update `metadata.last-reviewed` when the facts have been re-checked, and add an entry to [CHANGELOG.md](CHANGELOG.md).
- Run `claude plugin validate .` and the evals before opening a pull request.

## Credits

- Google Search Central, Bing Webmaster, schema.org, web.dev, [llmstxt.org](https://llmstxt.org/), [IndexNow](https://www.indexnow.org/).
- Aggarwal et al., [GEO: Generative Engine Optimization](https://arxiv.org/abs/2311.09735), 2023.
- Laurent Bourrelly's semantic cocoon method.
- Community skills that inspired the scope, without copying them: [agricidaniel/claude-seo](https://claudemarketplaces.com/skills/agricidaniel/claude-seo/seo-geo) (AI crawler access, quotable passages, llms.txt) and [infrasity-labs/dev-gtm-claude-skills](https://github.com/infrasity-labs/dev-gtm-claude-skills) (AI-readiness audit).

## Licence

[CC BY 4.0](LICENSE): you may share and adapt this skill, including commercially, as long as you credit Geoffrey Crofte and link to this repository.

## Author

[Geoffrey Crofte](https://github.com/geoffreycrofte)
