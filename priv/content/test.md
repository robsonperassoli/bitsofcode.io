---
author: Test Author
title: "Comprehensive Markdown Test Document"
date: 2025-08-27
description: "A complete test file covering all common markdown syntax elements"
tags: ["markdown", "test", "documentation"]
---
# Markdown Syntax Test Document

This document tests all common markdown syntax elements for comprehensive formatting validation.

## Headers

### Third Level Header
#### Fourth Level Header
##### Fifth Level Header
###### Sixth Level Header

## Text Formatting

**Bold text** and __also bold text__

*Italic text* and _also italic text_

***Bold and italic*** and ___also bold and italic___

~~Strikethrough text~~

Regular text with `inline code` formatting.

## Lists

### Unordered Lists

- First item
- Second item
  - Nested item
  - Another nested item
    - Deeply nested item
- Third item

* Alternative bullet style
* Second item
* Third item

### Ordered Lists

1. First ordered item
2. Second ordered item
   1. Nested ordered item
   2. Another nested item
3. Third ordered item

## Links and References

[Inline link](https://example.com)

[Link with title](https://example.com "Example Website")

<https://direct-url.com>

[Reference link][1]

[1]: https://example.com "Reference link title"

## Images

![Alt text](https://placehold.co/150x100 "Image title")

![Reference style image][image1]

[image1]: https://placehold.co/300x200 "Reference image"

## Code

### Inline Code

Use `console.log()` to output in JavaScript.

### Code Blocks

```javascript
function greetUser(name) {
  console.log(`Hello, ${name}!`);
  return `Welcome, ${name}`;
}

greetUser("World");
```

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

print(fibonacci(10))
```

```elixir
defmodule Calculator do
  def add(a, b), do: a + b
  def multiply(a, b), do: a * b
end

Calculator.add(5, 3)
```

```bash
# Shell commands
ls -la
cd /home/user
git status
```

## Blockquotes

> This is a blockquote.
> It can span multiple lines.

> **Nested blockquote example:**
>
> > This is a nested blockquote.
> > It demonstrates quote nesting.
>
> Back to the first level quote.

## Tables

| Header 1    | Header 2    | Header 3    |
|-------------|-------------|-------------|
| Row 1 Col 1 | Row 1 Col 2 | Row 1 Col 3 |
| Row 2 Col 1 | Row 2 Col 2 | Row 2 Col 3 |
| Row 3 Col 1 | Row 3 Col 2 | Row 3 Col 3 |

### Table with Alignment

| Left Aligned | Center Aligned | Right Aligned |
|:-------------|:--------------:|--------------:|
| Left         |    Center      |         Right |
| Left text    |  Center text   |    Right text |
| L            |        C       |             R |

## Horizontal Rules

---

***

___

## Line Breaks and Spacing

This is a paragraph with a
manual line break using two spaces.

This is a new paragraph after a blank line.

## Special Characters and Escaping

\*Escaped asterisks\*

\`Escaped backticks\`

\# Escaped hash

## Task Lists

- [x] Completed task
- [x] Another completed task
- [ ] Incomplete task
- [ ] Another incomplete task

## Footnotes

This text has a footnote[^1].

This is another footnote reference[^note].

[^1]: This is the first footnote.
[^note]: This is a named footnote with more detailed information.

## Definition Lists

Term 1
:   Definition for term 1

Term 2
:   Definition for term 2
:   Another definition for term 2

## Abbreviations

*[HTML]: Hyper Text Markup Language
*[CSS]: Cascading Style Sheets

HTML and CSS are fundamental web technologies.

## Math (if supported)

Inline math: $E = mc^2$

Block math:
$$
\sum_{i=1}^{n} x_i = x_1 + x_2 + \ldots + x_n
$$

## HTML Elements (if supported)

<details>
<summary>Click to expand</summary>
This content is hidden by default and can be expanded.
</details>

<kbd>Ctrl</kbd> + <kbd>C</kbd> to copy

<mark>Highlighted text</mark>

## End of Document

This comprehensive test document covers:
- Headers (H1-H6)
- Text formatting (bold, italic, strikethrough)
- Lists (ordered, unordered, nested)
- Links (inline, reference, direct)
- Images (inline, reference)
- Code (inline, blocks with syntax highlighting)
- Blockquotes (simple, nested)
- Tables (basic, aligned)
- Horizontal rules
- Line breaks
- Special characters
- Task lists
- Footnotes
- Definition lists
- Abbreviations
- Math expressions
- HTML elements

Perfect for testing markdown rendering engines!
