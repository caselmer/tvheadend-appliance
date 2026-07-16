#!/bin/sh
#
# TVHeadend Appliance
# Common Functions
#

###############################################################################
# Farben nur wenn Terminal vorhanden
###############################################################################

if [ -t 1 ]; then
    RED="$(printf '\033[1;31m')"
    GREEN="$(printf '\033[1;32m')"
    YELLOW="$(printf '\033[1;33m')"
    BLUE="$(printf '\033[1;34m')"
    RESET="$(printf '\033[0m')"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    RESET=""
fi

###############################################################################
# Logging
###############################################################################

info() {
    printf "%s[INFO]%s %s\n" "$BLUE" "$RESET" "$1"
}

success() {
    printf "%s[ OK ]%s %s\n" "$GREEN" "$RESET" "$1"
}

warn() {
    printf "%s[WARN]%s %s\n" "$YELLOW" "$RESET" "$1"
}

fatal() {
    printf "%s[FAIL]%s %s\n" "$RED" "$RESET" "$1" >&2
    exit 1
}

###############################################################################
# Prüfungen
###############################################################################

require_root() {

    if [ "$(id -u)" -ne 0 ]; then
        fatal "Dieses Script muss als root ausgeführt werden."
    fi

}

require_debian12() {

    [ -f /etc/os-release ] || fatal "/etc/os-release fehlt."

    . /etc/os-release

    [ "$ID" = "debian" ] || fatal "Nur Debian wird unterstützt."

    [ "$VERSION_CODENAME" = "bookworm" ] || \
        fatal "Nur Debian 12 (Bookworm) wird unterstützt."

}

