#!/usr/bin/env bash

#
# TVHeadend Appliance
# Common functions
#

set -Eeuo pipefail

LOGFILE="/var/log/tvheadend-appliance.log"

###############################################################################
# Logging
###############################################################################

log() {
    echo "[$(date '+%F %T')] $*" | tee -a "$LOGFILE"
}

info() {
    log "[INFO] $*"
}

success() {
    log "[ OK ] $*"
}

warn() {
    log "[WARN] $*"
}

error() {
    log "[FAIL] $*"
}

die() {
    error "$*"
    exit 1
}

###############################################################################
# Error handling
###############################################################################

on_error() {
    local exit_code=$?
    error "Installation abgebrochen (Exit-Code ${exit_code})."
    exit "$exit_code"
}

trap on_error ERR

###############################################################################
# Output
###############################################################################

print_header() {

cat <<'EOF'

=========================================
      TVHeadend Appliance Installer
              Version 0.2.0
=========================================

EOF

}

###############################################################################
# System checks
###############################################################################

check_root() {

    if [[ $EUID -ne 0 ]]; then
        die "Bitte als root ausführen."
    fi

    success "Root-Rechte vorhanden."
}

check_os() {

    [[ -f /etc/os-release ]] || die "Betriebssystem nicht erkannt."

    # shellcheck disable=SC1091
    source /etc/os-release

    [[ "$ID" == "debian" ]] || die "Nur Debian wird unterstützt."
    [[ "$VERSION_ID" == "12" ]] || die "Nur Debian 12 wird unterstützt."

    success "Debian 12 erkannt."
}

check_internet() {

    info "Prüfe Internetverbindung..."

    ping -c1 1.1.1.1 >/dev/null 2>&1 \
        || die "Keine Internetverbindung."

    success "Internetverbindung vorhanden."
}

check_diskspace() {

    info "Prüfe freien Speicher..."

    local free

    free=$(df --output=avail / | tail -1)

    (( free >= 1048576 )) \
        || die "Mindestens 1 GB freier Speicher erforderlich."

    success "Genügend Speicher vorhanden."
}

check_memory() {

    info "Prüfe Arbeitsspeicher..."

    local mem

    mem=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

    (( mem >= 900000 )) \
        || die "Mindestens 1 GB RAM erforderlich."

    success "Genügend Arbeitsspeicher vorhanden."
}

###############################################################################
# Installer phases
###############################################################################

load_config() {

    for cfg in \
        "$SCRIPT_DIR/config/system.conf" \
        "$SCRIPT_DIR/config/tvheadend.conf" \
        "$SCRIPT_DIR/config/iptv.conf" \
        "$SCRIPT_DIR/config/epg.conf"
    do
        [[ -f "$cfg" ]] || die "Konfigurationsdatei fehlt: $cfg"
        # shellcheck disable=SC1090
        source "$cfg"
    done

    # Optional: TVHeadend API credentials
    if [[ -f "$SCRIPT_DIR/config/tvheadend.credentials" ]]; then
        # shellcheck disable=SC1090
        source "$SCRIPT_DIR/config/tvheadend.credentials"
    fi

    success "Konfiguration geladen."
}


preflight() {

    info "Starte Systemprüfung..."

    check_root
    check_os
    check_internet
    check_diskspace
    check_memory

    success "Systemprüfung abgeschlossen."
}

finish() {

    echo
    success "Installation erfolgreich abgeschlossen."
    echo
}
