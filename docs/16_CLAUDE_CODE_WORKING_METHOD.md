# Claude Code Working Method Used by This Kit

This repository separates persistent facts from repeatable procedures:

- `CLAUDE.md` contains concise project invariants and common commands.
- `.claude/rules/` contains modular and path-scoped rules.
- `.claude/agents/` contains project-specific specialist subagents with constrained roles.
- `.claude/skills/` contains reusable multi-step workflows that load only when invoked.
- `.claude/settings.json` contains shared project permissions and a blocking hook.
- Plans, ADRs, tests, and traceability provide evidence outside the conversation context.

## Expected Claude Code behavior

- Inspect the codebase before editing.
- Plan large work before touching disk.
- Delegate narrow analysis to specialist subagents to keep the main context focused.
- Implement in vertical slices.
- Run tests and the actual application instead of relying only on static inspection.
- Use hooks and permissions for enforceable restrictions; instructions alone are not security controls.
- Keep project settings in source control and personal/local settings outside source control.

## Official references

- Claude Code memory and project rules: https://code.claude.com/docs/en/memory
- Subagents: https://code.claude.com/docs/en/sub-agents
- Skills: https://code.claude.com/docs/en/skills
- Settings: https://code.claude.com/docs/en/settings
- Hooks: https://code.claude.com/docs/en/hooks
- Security: https://code.claude.com/docs/en/security
- Common workflows: https://code.claude.com/docs/en/common-workflows
