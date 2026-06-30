#!/usr/bin/env bash
set -euo pipefail

INPUT="$(cat)"
COMMAND="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // ""')"

DENY_REASON=""

case "$COMMAND" in
  *"rm -rf /"*|*"rm -rf ~"*|*"rm -rf ."*|*"git reset --hard"*|*"git clean -fd"*|*"git push --force"*|*"git push -f"*|*"sudo "*|*"curl "*"| sh"*|*"wget "*"| sh"*)
    DENY_REASON="Destructive or unreviewed privileged command blocked by project policy."
    ;;
esac

if [[ -n "$DENY_REASON" ]]; then
  jq -n --arg reason "$DENY_REASON" '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: $reason
    }
  }'
else
  exit 0
fi
