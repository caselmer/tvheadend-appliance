#!/bin/sh
#
# TVHeadend Appliance
# Version: 0.1.0
#

set -eu

VERSION="0.1.0"

###############################################################################
# Farben
###############################################################################

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

###############################################################################
# Funktionen
###############################################################################

info() {
    printf "${BLUE}[INFO]${RESET} %s\n" "$1"
}

success() {
    printf "${GREEN}[ OK ]${RESET} %s\n" "$1"
}

warn() {
    printf "${YELLOW}[WARN]${RESET} %s\n" "$1"
}

error() {
    printf "${RED}[FAIL]${RESET} %s\n" "$1"
    exit 1
}

###############################################################################
# Banner
###############################################################################

clear

echo
echo "=============================================="
echo "      TVHeadend Appliance ${VERSION}"
echo "=============================================="
echo

###############################################################################
# Root prüfen
###############################################################################

if [ "$(id -u)" -ne 0 ]; then
    error "Bitte als root oder mit sudo starten."
fi

success "Root-Rechte vorhanden"

###############################################################################
# Betriebssystem prüfen
###############################################################################

if [ ! -f /etc/os-release ]; then
    error "/etc/os-release nicht gefunden."
fi

. /etc/os-release

if [ "$ID" != "debian" ]; then
    error "Nur Debian wird unterstützt."
fi

if [ "$VERSION_CODENAME" != "bookworm" ]; then
    error "Nur Debian 12 (Bookworm) wird unterstützt."
fi

success "Debian 12 erkannt"

###############################################################################
# .env laden
###############################################################################

if [ -f ".env" ]; then
    info "Lade .env"
    # shellcheck disable=SC1091
    . ./.env
else
    warn "Keine .env gefunden."
    warn "Bitte .env.example nach .env kopieren."
fi

echo
success "Systemprüfung erfolgreich"
echo
info "Installation folgt in Meilenstein 3"

