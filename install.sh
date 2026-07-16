#!/bin/sh

set -eu

VERSION="0.1.0"

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)

. "$SCRIPT_DIR/scripts/common.sh"

echo
echo "========================================="
echo " TVHeadend Appliance ${VERSION}"
echo "========================================="
echo

require_root
success "Root-Rechte vorhanden"

require_debian12
success "Debian 12 erkannt"

echo

info "Grundsystem bereit."

info "Installation folgt in Meilenstein 3."

