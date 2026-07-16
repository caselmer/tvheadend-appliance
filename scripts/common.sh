#!/usr/bin/env bash

print_header() {

cat <<EOF

=========================================
      TVHeadend Appliance Installer
               Version 0.2.0
=========================================

EOF

}

check_root() {

if [[ $EUID -ne 0 ]]; then
    echo "Bitte als root ausführen."
    exit 1
fi

}

check_os() {

if [[ ! -f /etc/os-release ]]; then
    echo "Betriebssystem nicht erkannt."
    exit 1
fi

source /etc/os-release

if [[ "$ID" != "debian" ]]; then
    echo "Nur Debian wird unterstützt."
    exit 1
fi

if [[ "$VERSION_ID" != "12" ]]; then
    echo "Nur Debian 12 wird unterstützt."
    exit 1
fi

}
LOGFILE="/var/log/tvheadend-appliance.log"

log() {
    echo "[$(date '+%F %T')] $*" | tee -a "$LOGFILE"
}

info() {
    log "[INFO] $*"
}

success() {
    log "[ OK ] $*"
}

error() {
    log "[FAIL] $*"
}

die() {
    error "$*"
    exit 1
}
on_error() {

    local exit_code=$?

    error "Installation abgebrochen (Exit-Code $exit_code)."

    exit "$exit_code"
}

trap on_error ERR

