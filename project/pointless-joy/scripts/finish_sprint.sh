#!/bin/zsh
set -euo pipefail

SPRINT="${1:-}"
if [[ -z "$SPRINT" ]]; then
  echo "Usage: ./scripts/finish_sprint.sh <sprint-number>"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# ---- Safety guard: ensure this is pointless-joy repo ----
if [[ ! -f "PRODUCT_SPEC.md" ]]; then
  echo "❌ Guard fail: PRODUCT_SPEC.md not found. Wrong project?"
  exit 1
fi
if ! grep -qi "Pointless Joy\|무용한 기쁨\|무용한기쁨" PRODUCT_SPEC.md; then
  echo "❌ Guard fail: PRODUCT_SPEC.md does not look like pointless-joy."
  echo "   Refusing to run to avoid mixing with find-my-home."
  exit 1
fi

DATE_KST="$(TZ=Asia/Seoul date +%F)"
DATE_TS="$(TZ=Asia/Seoul date +%Y%m%d-%H%M)"
AGENTS_RETRO="docs/retros/sprint-${SPRINT}-agents-retro.md"
PO_RETRO="docs/retros/sprint-${SPRINT}-po-retro.md"
SUMMARY="docs/retros/sprint-${SPRINT}-summary.md"
ARCHIVE_DIR="archives"
ARCHIVE_FILE="${ARCHIVE_DIR}/pointless-joy-sprint-${SPRINT}-${DATE_TS}.tar.gz"
ARCHIVE_INDEX="${ARCHIVE_DIR}/INDEX.md"

mkdir -p docs/retros "$ARCHIVE_DIR"

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
  git commit -m "pointless: finish sprint ${SPRINT} with retros"
else
  echo "No changes to commit."
fi

COMMIT_HASH="$(git rev-parse --short HEAD)"

# Archive current version (viewable by PO)
git archive --format=tar.gz -o "$ARCHIVE_FILE" HEAD

if [[ ! -f "$ARCHIVE_INDEX" ]]; then
cat > "$ARCHIVE_INDEX" <<EOF
# Pointless Joy Version Archive

| Sprint | Date (KST) | Commit | Archive |
|---|---|---|---|
EOF
fi

echo "| ${SPRINT} | ${DATE_KST} | \\`${COMMIT_HASH}\\` | \\`${ARCHIVE_FILE}\\` |" >> "$ARCHIVE_INDEX"

# Commit archive/index changes
if [[ -n "$(git status --porcelain)" ]]; then
  git add -A
  git commit -m "pointless: archive sprint ${SPRINT} (${COMMIT_HASH})"
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
echo "Archive: $ARCHIVE_FILE"
echo "Index:   $ARCHIVE_INDEX"
