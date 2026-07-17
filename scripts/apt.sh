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

install_dependencies() {

    info "Installiere benötigte Pakete..."

    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
        curl \
        ca-certificates \
        wget \
        jq

    success "Abhängigkeiten installiert."
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

}
