#!/bin/sh

set -eu

update_system() {

    info "Aktualisiere Paketlisten..."

    apt-get update

    success "Paketlisten aktualisiert"

}

install_base_packages() {

    info "Installiere Grundpakete..."

    apt-get install -y \
        ca-certificates \
        curl \
        wget \
        jq \
        gnupg \
        lsb-release \
        apt-transport-https

    success "Grundpakete installiert"

}

