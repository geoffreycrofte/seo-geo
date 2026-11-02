---
type: llm
---

PASS if the reply blocks training crawlers (at least GPTBot, Google-Extended and CCBot) while explicitly keeping search or retrieval bots allowed (at least OAI-SearchBot or PerplexityBot or Claude-SearchBot), keeps a Sitemap line or recommends one, and says that bot names should be checked against the vendors' current documentation.
FAIL if it blocks all AI bots, blocks OAI-SearchBot or PerplexityBot, claims Google-Extended affects Google Search ranking, or omits any caveat about bot names changing.
