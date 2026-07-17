#!/usr/bin/env bash

#
# TVHeadend Appliance
# TVHeadend installation
#

###############################################################################
# Install TVHeadend
###############################################################################

install_tvheadend() {

    if dpkg -s tvheadend >/dev/null 2>&1; then
        success "TVHeadend ist bereits installiert."
        return
    fi

    info "Installiere TVHeadend..."

    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y tvheadend

    success "TVHeadend wurde installiert."
}

###############################################################################
# Enable service
###############################################################################

enable_tvheadend() {

    info "Starte TVHeadend..."

    systemctl enable tvheadend
    systemctl restart tvheadend

    success "TVHeadend läuft."

}

###############################################################################
# Installation phase
###############################################################################

install_tvheadend_stack() {

    install_tvheadend
    enable_tvheadend

}
