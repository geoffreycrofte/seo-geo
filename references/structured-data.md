# Structured data (JSON-LD)

## Rules

- Generate it from the same data as the page. Describe only what is visible on the page.
- Useful types: `WebSite`, `Organization` (with `logo` and `sameAs`), `Person`, `BreadcrumbList`, `Article` or `BlogPosting` (with `datePublished`, `dateModified`, `author`, `image`), `Product` with `Offer` (only if you sell on the page), `VideoObject`, `ItemList`.
- Keep entities consistent across the site: the same `@id`, name spelling and `sameAs` profiles for the `Organization` and each `Person`. This is what lets search engines and models connect the brand and authors (GEO, `SKILL.md` §5).
- **Rich result status changes**: since 2023, Google shows FAQ rich results only for authoritative government and health sites, and no longer shows HowTo rich results. The markup still helps other engines and models understand the page. Check the current list in Google's documentation before promising a rich result.
- Validate with the [Rich Results Test](https://search.google.com/test/rich-results) and the [Schema Markup Validator](https://validator.schema.org/).

## Example: article page

One `@graph` per page, with stable `@id`s that other pages reuse.

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": "https://example.com/#org",
      "name": "Example Coffee",
      "url": "https://example.com/",
      "logo": "https://example.com/logo.png",
      "sameAs": ["https://social.example/@examplecoffee"]
    },
    {
      "@type": "Person",
      "@id": "https://example.com/#jane",
      "name": "Jane Doe",
      "url": "https://example.com/about/",
      "sameAs": ["https://social.example/@janedoe"]
    },
    {
      "@type": "BlogPosting",
      "@id": "https://example.com/guides/burr-grinder/#article",
      "headline": "Choosing a burr grinder",
      "description": "How to pick a burr grinder for espresso.",
      "image": "https://example.com/og/burr-grinder.jpg",
      "datePublished": "2026-03-14",
      "dateModified": "2026-10-02",
      "author": { "@id": "https://example.com/#jane" },
      "publisher": { "@id": "https://example.com/#org" },
      "mainEntityOfPage": "https://example.com/guides/burr-grinder/",
      "inLanguage": "en"
    },
    {
      "@type": "BreadcrumbList",
      "itemListElement": [
        { "@type": "ListItem", "position": 1, "name": "Guides", "item": "https://example.com/guides/" },
        { "@type": "ListItem", "position": 2, "name": "Choosing a burr grinder" }
      ]
    }
  ]
}
</script>
```
