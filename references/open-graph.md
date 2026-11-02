# Social sharing (Open Graph)

- On every page: `og:title`, `og:description`, `og:url` (the canonical), `og:type` (`website` or `article`), `og:image`, `og:site_name`, `og:locale` (plus `og:locale:alternate` on multilingual sites), and `twitter:card=summary_large_image`.
- Image: 1200 × 630 px (ratio 1.91:1), under about 1 MB, absolute URL, subject centred because each platform crops differently. Use the article's cover when it has one, and a branded default otherwise. Add `og:image:alt`.
- Pinterest favours tall, legible images with descriptive `alt` text in the page. Plan for it when the niche is visual.
- Check with the platforms' debuggers (Facebook Sharing Debugger, LinkedIn Post Inspector) or by pasting the link into a draft post.

```html
<meta property="og:type" content="article">
<meta property="og:title" content="Choosing a burr grinder">
<meta property="og:description" content="How to pick a burr grinder for espresso: burr types, grind range and the three models I tested for a year.">
<meta property="og:url" content="https://example.com/guides/burr-grinder/">
<meta property="og:image" content="https://example.com/og/burr-grinder.jpg">
<meta property="og:image:alt" content="Three burr grinders side by side on a kitchen counter">
<meta property="og:site_name" content="Example Coffee">
<meta property="og:locale" content="en_GB">
<meta property="og:locale:alternate" content="fr_FR">
<meta name="twitter:card" content="summary_large_image">
```
