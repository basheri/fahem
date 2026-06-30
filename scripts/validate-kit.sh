#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

required=(
  README.md
  MASTER_PROMPT.md
  CLAUDE.md
  .env.example
  .claude/settings.json
  docs/01_PRD.md
  docs/03_ARCHITECTURE.md
  docs/09_SECURITY_AND_PRIVACY.md
  docs/12_ACCEPTANCE_CRITERIA.md
  docs/TRACEABILITY_MATRIX.md
  contracts/openapi.yaml
  schemas/answer.schema.json
)

for file in "${required[@]}"; do
  [[ -f "$file" ]] || { echo "Missing required file: $file" >&2; exit 1; }
done

python3 - <<'PYJSON'
import json
from pathlib import Path
for path in list(Path('schemas').glob('*.json')) + [Path('.claude/settings.json')]:
    json.loads(path.read_text(encoding='utf-8'))
    print(f'valid json: {path}')
PYJSON

bash -n .claude/hooks/block-dangerous.sh

# Dependency and build directories are gitignored third-party output; do not scan them.
prune_dirs=(--exclude-dir='.git' --exclude-dir='node_modules' --exclude-dir='.venv' \
  --exclude-dir='.next' --exclude-dir='dist' --exclude-dir='coverage' \
  --exclude-dir='.mypy_cache' --exclude-dir='.ruff_cache' --exclude-dir='.pytest_cache')

if grep -RInE --exclude='.env.example' --exclude='validate-kit.sh' "${prune_dirs[@]}" '(sk-or-v1-[A-Za-z0-9_-]{20,}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)' .; then
  echo "Potential secret detected" >&2
  exit 1
fi

if grep -RIl $'\r' --include='*.md' --include='*.json' --include='*.yaml' --include='*.yml' "${prune_dirs[@]}" . | grep -q .; then
  echo "CRLF line endings detected" >&2
  exit 1
fi

echo "Fahem AI Claude Code kit validation passed."
