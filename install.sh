#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/scripts/common.sh"
source "$SCRIPT_DIR/scripts/apt.sh"
source "$SCRIPT_DIR/scripts/tvheadend.sh"
source "$SCRIPT_DIR/scripts/iptv.sh"
source "$SCRIPT_DIR/scripts/epg.sh"

main() {

    print_header
    load_config
    preflight

    install_system
    install_tvheadend_stack

    configure_iptv
    configure_epg

    finish
}

main "$@"
