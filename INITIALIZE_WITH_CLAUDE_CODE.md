# Initialize the Project with Claude Code

## First session

From the repository root:

```bash
claude
```

Then submit:

```text
Read CLAUDE.md, MASTER_PROMPT.md, all project rules, and all specifications. Do not write application code yet. Produce the Phase 0 repository-aware plan, identify conflicts or missing decisions, create ADR stubs for material decisions, and map the first implementation slices to acceptance criteria. Then proceed with Phase 1 unless a genuine external blocker exists.
```

## Recommended operating pattern

- Use plan mode before large or cross-cutting edits.
- Delegate focused reviews to project subagents.
- Use `/implement-slice` for each vertical slice.
- Use `/security-audit` before merging security-sensitive changes.
- Use `/verify-release` at milestone boundaries.
- After the local stack is working, run `/run-skill-generator` to record the exact startup process for `/run` and `/verify`.
- Keep the main branch protected; develop through feature branches and pull requests.

## Do not enable blanket bypass permissions

The repository includes conservative project settings and a destructive-command hook. Review permission prompts. Do not use `--dangerously-skip-permissions` for this project.
