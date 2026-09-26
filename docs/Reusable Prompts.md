## Quick Navigation

- [Why I Keep Reusable Prompts](#why-i-keep-reusable-prompts)
- [Where the Prompts Live](#where-the-prompts-live)
- [Use Prompts as Templates](#use-prompts-as-templates)
- [Keep Prompts Useful and Safe](#keep-prompts-useful-and-safe)

## Why I Keep Reusable Prompts

I often ask AI tools to help with tasks such as reviewing code, exploring an idea, explaining a project, or writing documentation. Reusable prompts help me provide the right instructions without rewriting them each time.

They also make my results more consistent. I can keep separate prompts for coding and documentation, then adapt the selected prompt to the task at hand.

## Where the Prompts Live

Reusable prompts live in the `prompts/` folder. Each file has a clear name describing its purpose, such as:

```text
prompts/
├── code.md
├── docs.md
```

## Use Prompts as Templates

A good reusable prompt has two parts: stable instructions that apply to many tasks, and parameters that I fill in for the current request. Parameters can describe the task, project context, source material, audience, output format, detail level, constraints, and how to handle missing information.

Before starting a chat, I copy the relevant prompt, fill in the parameters, and add the project-specific context. That gives the AI a clear task while allowing the same prompt to work across different projects.

## Keep Prompts Useful and Safe

Review prompts as workflows change. Remove instructions that no longer reflect how I work, and keep task-specific details out of general templates.

Do not put API keys, passwords, private connection strings, or confidential project material in reusable prompts. Add sensitive context only through an appropriate private workflow when it is actually needed.
