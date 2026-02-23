#!/bin/zsh
set -euo pipefail

SPRINT="${1:-}"
if [[ -z "$SPRINT" ]]; then
  echo "Usage: ./scripts/finish_sprint.sh <sprint-number>"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DATE_KST="$(TZ=Asia/Seoul date +%F)"
AGENTS_RETRO="docs/retros/sprint-${SPRINT}-agents-retro.md"
PO_RETRO="docs/retros/sprint-${SPRINT}-po-retro.md"

mkdir -p docs/retros

# Generate retrospective files if missing
if [[ ! -f "$AGENTS_RETRO" ]]; then
  sed "s/{{SPRINT}}/${SPRINT}/g" docs/retros/TEMPLATE-agents-retro.md > "$AGENTS_RETRO"
  echo "- generated $AGENTS_RETRO"
fi

if [[ ! -f "$PO_RETRO" ]]; then
  sed "s/{{SPRINT}}/${SPRINT}/g" docs/retros/TEMPLATE-po-retro.md > "$PO_RETRO"
  echo "- generated $PO_RETRO"
fi

# Sprint summary stub
SUMMARY="docs/retros/sprint-${SPRINT}-summary.md"
if [[ ! -f "$SUMMARY" ]]; then
cat > "$SUMMARY" <<EOF
# Sprint ${SPRINT} Summary (${DATE_KST})

## PRODUCT_SPEC 기준 진행
- 완료 항목:
- 미완료 항목:
- 다음 스프린트 이월 항목:

## 배포/릴리즈 메모
- 
EOF
fi

# Basic quality checks (best effort)
if command -v npm >/dev/null 2>&1 && [[ -f package.json ]]; then
  npm -s run build >/dev/null 2>&1 || echo "[warn] npm build failed or not configured"
fi

# Commit everything
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "chore(sprint): finish sprint ${SPRINT} with retros"
else
  echo "No changes to commit."
fi

# Auto push (requested policy)
if git remote get-url origin >/dev/null 2>&1; then
  BRANCH="$(git branch --show-current)"
  git push origin "$BRANCH"
  echo "✅ pushed to origin/$BRANCH"
else
  echo "⚠️ no origin remote configured. add remote then rerun push:"
  echo "   git remote add origin <repo-url>"
fi

echo "Done: sprint ${SPRINT} closed."
