---
type: llm
---

PASS if the reply flags all of: the generic title (should name the product, then the brand), the keyword-list description (should be a sentence promising what the page answers), the relative canonical (should be absolute), the two h1 elements, the image without alt, and the missing html lang attribute.
FAIL if two or more of these are missed, or if it recommends keyword stuffing.
