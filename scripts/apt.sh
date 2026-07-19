#!/usr/bin/env bash

#
# TVHeadend Appliance
# Package management
#

###############################################################################
# Update package lists
###############################################################################

update_package_lists() {

    info "Aktualisiere Paketlisten..."

    apt-get update

    success "Paketlisten aktualisiert."
}

###############################################################################
# Upgrade installed packages
###############################################################################

upgrade_system() {

    info "Installiere verfügbare Updates..."

    DEBIAN_FRONTEND=noninteractive \
    apt-get -y upgrade

    success "System aktualisiert."
}

###############################################################################
# Install required packages
###############################################################################

install_package() {

    local package="$1"

    if dpkg -s "$package" >/dev/null 2>&1; then
        success "Paket ${package} ist bereits installiert."
        return
    fi

    info "Installiere Paket: ${package}..."

    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y "$package"

    success "Paket ${package} installiert."

}


install_dependencies() {

    info "Installiere benötigte Pakete..."

    install_package curl
    install_package ca-certificates
    install_package jq
    install_package gnupg
    install_package debian-keyring
    install_package debian-archive-keyring
    # install_package etckeeper

    success "Abhängigkeiten installiert."

}


configure_tvheadend_repository() {

    info "Richte TVHeadend-Repository ein..."

    local keyring="/usr/share/keyrings/tvheadend-tvheadend-archive-keyring.gpg"
    local repo="/etc/apt/sources.list.d/tvheadend-tvheadend.list"

    if [[ -f "$repo" ]]; then
        success "TVHeadend-Repository bereits eingerichtet."
        return
    fi

    curl -1sLf \
        "https://dl.cloudsmith.io/public/tvheadend/tvheadend/gpg.C6CC06BD69B430C6.key" \
        | gpg --dearmor -o "$keyring"

    curl -1sLf \
        "https://dl.cloudsmith.io/public/tvheadend/tvheadend/config.deb.txt?distro=debian&codename=bookworm&component=main" \
        -o "$repo"

    chmod 644 "$keyring"
    chmod 644 "$repo"

    apt-get update

    success "TVHeadend-Repository eingerichtet."

}


###############################################################################
# Cleanup
###############################################################################

cleanup_system() {

    info "Bereinige Paketcache..."

    apt-get autoremove -y
    apt-get clean

    success "Bereinigung abgeschlossen."
}

###############################################################################
# Main
###############################################################################

install_system() {

    update_package_lists
    upgrade_system
    install_dependencies
    configure_tvheadend_repository
}
