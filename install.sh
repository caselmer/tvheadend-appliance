#!/bin/sh

set -eu

VERSION="0.1.0"

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname "$0")" && pwd)

. "$SCRIPT_DIR/scripts/common.sh"
. "$SCRIPT_DIR/scripts/apt.sh"

echo
echo "==============================================="
echo " TVHeadend Appliance ${VERSION}"
echo "==============================================="
echo

require_root
success "Root-Rechte vorhanden"

require_debian12
success "Debian 12 erkannt"

update_system

install_base_packages

success "Grundsystem vorbereitet"

