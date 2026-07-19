#!/usr/bin/env bash

###############################################################################
# TVHeadend Appliance
# Validation
###############################################################################

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$PROJECT_DIR"

echo
echo "========================================="
echo "      TVHeadend Appliance Validation"
echo "========================================="
echo

echo "[1/4] Prüfe Bash-Syntax..."
bash -n install.sh
bash -n scripts/*.sh

echo "[2/4] Prüfe mit ShellCheck..."
shellcheck install.sh scripts/*.sh

echo "[3/4] Git-Status..."
git status --short

echo "[4/4] Validierung abgeschlossen."

echo
success "Projektvalidierung erfolgreich."
