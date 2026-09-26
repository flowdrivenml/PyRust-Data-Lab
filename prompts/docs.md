# Documentation Prompt

## Quick Navigation

- [Parameters](#parameters)
- [Instructions](#instructions)
- [Markdown and Obsidian Style](#markdown-and-obsidian-style)
- [Structure and Supporting Elements](#structure-and-supporting-elements)
- [Source Material](#source-material)
- [Requested Output](#requested-output)

## Parameters

Fill in the task details. Choose one value for categorical fields where applicable; use the defaults if a field is blank.

```yaml
mode: "[create | revise | review | explain | plan]"
task: "[What should be done?]"
subject: "[What is the work about?]"
audience: "[beginner | general | technical | expert | mixed]"
context: "[Relevant background]"
source_material: "[Files, notes, code, links, or other evidence to use]"
output_format: "[Markdown | plain text | code | table | checklist]"
markdown_profile: "[Obsidian | CommonMark | MkDocs Material | GitHub | plain Markdown]"
detail_level: "[minimal | concise | standard | detailed | comprehensive]"
style: "[neutral | casual | technical | formal | instructional]"
presentation_balance: "[prose-led | balanced | list-led | scan-first | narrative]"
information_density: "[minimal | concise | standard | detailed | comprehensive]"
supporting_elements: "[adaptive | prose-only | tables | Mermaid diagrams | examples and code]"
element_policy: "[requested-only | prose-only | adaptive | visual-first | comprehensive]"
constraints: "[Requirements, exclusions, tools, length, compatibility]"
missing_information: "[ask | state assumptions | mark unknown | omit]"
verification:
  - "[accuracy | consistency | citations-and-links | code-and-commands | formatting]"
```

Use freeform text for task-specific fields such as `task`, `subject`, `context`, `source_material`, and `constraints`. For `verification`, select only checks relevant to the task.

## Instructions

Complete the requested task using the supplied context and source material. Follow the selected audience, format, detail level, style, presentation balance, and constraints.

Treat supplied source material as authoritative for the task. Do not invent facts, evidence, references, APIs, results, or implementation details. If information is missing, follow `missing_information`. Distinguish confirmed information from assumptions and recommendations.

Organize the result so the intended audience can use it directly. Explain important reasoning and include relevant detail, but avoid repetition, filler, and unrelated sections.

Before responding, check the result against the task, source material, constraints, and selected verification requirements.

## Markdown and Obsidian Style

When producing a Markdown document:

- Return the complete document in one copyable Markdown block. Use an outer four-backtick fence so nested code blocks remain intact.
- Use clear `##` and `###` headings.
- Add a `Quick Navigation` section near the top.
- Make every Quick Navigation entry a clickable Markdown link to a real heading in the same document.
- Use standard heading anchors: lowercase the heading, replace spaces with hyphens, and remove punctuation where necessary. Check each link against its heading.
- Do not use Obsidian wiki links such as `[[#Heading]]` or HTML anchors.
- Keep sections easy to scan and use filenames and links appropriate to the selected Markdown profile.
- Preserve supplied code blocks and commands exactly when they are relevant.

## Structure and Supporting Elements

Use connected prose as the default. Follow `presentation_balance`; use bullets for short sets of parallel items rather than turning every explanation into a list.

Use `supporting_elements` according to `element_policy`:

- Use tables for comparisons, mappings, parameters, or repeated structured data.
- Use Mermaid diagrams for meaningful relationships, architecture, sequences, or workflows when a diagram clarifies them better than prose. Keep diagrams simple and valid.
- Use charts only when relevant quantitative data is available and a chart adds insight.
- Use examples and code blocks when they help the reader apply or verify the explanation.
- Use callouts sparingly for important warnings or constraints.

Do not add decorative diagrams, unnecessary tables, or code fences around ordinary prose. If a requested element would not improve the document, explain the content clearly without forcing that element.

## Source Material

[Paste or describe the files, notes, code, links, results, or other material to use here.]

## Requested Output

[Describe the specific result you want.]
