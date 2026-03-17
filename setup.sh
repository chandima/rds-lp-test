#!/usr/bin/env bash
# RDS Landing Page Factory — post-scaffold setup
# Each step runs independently; failures are reported but don't abort.

REGISTRY="https://npm.edpl.us/"

# ── Step 1: Verify / create registry configuration ──────────────
echo "==> Verifying registry configuration..."

# .npmrc — used by Yarn Classic (1.x) and npm
if [ ! -f .npmrc ] || ! grep -q "$REGISTRY" .npmrc 2>/dev/null; then
  echo "    Creating .npmrc → $REGISTRY"
  echo "registry=${REGISTRY}" > .npmrc
fi

# .yarnrc.yml — required by Yarn 2+ (Berry / 4.x)
if command -v yarn &>/dev/null; then
  yarn_ver=$(yarn --version 2>/dev/null)
  yarn_major=$(echo "$yarn_ver" | cut -d. -f1)
  if [ "${yarn_major:-0}" -ge 2 ] 2>/dev/null; then
    if [ ! -f .yarnrc.yml ] || ! grep -q "$REGISTRY" .yarnrc.yml 2>/dev/null; then
      echo "    Creating .yarnrc.yml for Yarn ${yarn_ver} → $REGISTRY"
      printf 'npmRegistryServer: "%s"\nnodeLinker: node-modules\n' "$REGISTRY" > .yarnrc.yml
    fi
    echo "    ✓ Yarn ${yarn_ver} registry: $REGISTRY"
  else
    echo "    ✓ Yarn ${yarn_ver} registry (via .npmrc): $REGISTRY"
  fi
else
  echo "    ⚠ Yarn not found — install Yarn first: corepack enable && corepack prepare yarn@4 --activate"
fi

# ── Step 2: Install dependencies ────────────────────────────────
echo "==> Installing dependencies..."
if yarn install; then
  echo "    ✓ Dependencies installed"
else
  echo ""
  echo "    ✗ yarn install failed."
  echo "      Verify you have access to ${REGISTRY}"
  echo "      Check config: .yarnrc.yml (Yarn 4) or .npmrc (Yarn 1)"
  echo ""
fi

# ── Step 3: Select coding agents & install skills ────────────────
AGENTS=("codex" "opencode" "claude-code" "github-copilot")
LABELS=("Codex CLI" "OpenCode" "Claude Code" "GitHub Copilot")
SELECTED=(1 1 1 1)  # all selected by default

echo "==> Select coding agent(s) to install skills for:"

# Non-interactive mode: SETUP_AGENTS=codex,opencode,claude-code,github-copilot
if [ -n "${SETUP_AGENTS:-}" ]; then
  echo "    (using SETUP_AGENTS env var)"
  SELECTED=(0 0 0 0)
  IFS=',' read -ra _requested <<< "$SETUP_AGENTS"
  for req in "${_requested[@]}"; do
    for i in "${!AGENTS[@]}"; do
      if [ "$req" = "${AGENTS[$i]}" ]; then
        SELECTED[$i]=1
      fi
    done
  done
else
  # Interactive multi-select menu
  while true; do
    echo ""
    for i in "${!AGENTS[@]}"; do
      if [ "${SELECTED[$i]}" -eq 1 ]; then
        mark="x"
      else
        mark=" "
      fi
      echo "    [$mark] $((i+1))) ${LABELS[$i]}"
    done
    echo ""
    echo "    Toggle: 1-4 | All: a | None: n | Confirm: Enter"
    read -rp "    > " choice
    case "$choice" in
      1|2|3|4)
        idx=$((choice - 1))
        SELECTED[$idx]=$(( 1 - ${SELECTED[$idx]} ))
        ;;
      a|A) SELECTED=(1 1 1 1) ;;
      n|N) SELECTED=(0 0 0 0) ;;
      "") break ;;
      *) echo "    Invalid input — enter 1-4, a, n, or press Enter" ;;
    esac
  done
fi

# Show selection summary
AGENT_FLAGS=""
echo ""
echo "    Selected agents:"
any_selected=0
for i in "${!AGENTS[@]}"; do
  if [ "${SELECTED[$i]}" -eq 1 ]; then
    echo "      ✓ ${LABELS[$i]}"
    AGENT_FLAGS="$AGENT_FLAGS -a ${AGENTS[$i]}"
    any_selected=1
  fi
done

if [ "$any_selected" -eq 0 ]; then
  echo "      (none)"
  echo "    Skipping skills installation."
  echo ""
  echo "    To install later: npx skills add chandima/rds-lp-factory --skill '*' -a <agent> -y"
else
  echo ""
  echo "==> Installing agent skills..."
  if npx skills add chandima/rds-lp-factory --skill '*'$AGENT_FLAGS -y; then
    echo "    ✓ Agent skills installed"
  else
    echo ""
    echo "    ✗ Skills installation failed (non-critical)."
    echo "      Retry later: npx skills add chandima/rds-lp-factory --skill '*'$AGENT_FLAGS -y"
    echo ""
  fi
fi

echo "==> Setup complete! Run 'yarn dev' to start development."
