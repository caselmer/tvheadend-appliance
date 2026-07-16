#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/scripts/common.sh"
source "$SCRIPT_DIR/scripts/apt.sh"

main() {

    print_header

    check_root
    check_os

    info "Starte Installation..."
    update_system
    success "Grundinstallation abgeschlossen."

    echo
}

main "$@"

