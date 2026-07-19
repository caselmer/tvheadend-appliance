#!/usr/bin/env bash

###############################################################################
# Install TVHeadend
###############################################################################

install_tvheadend() {

    info "Installiere TVHeadend..."

    install_package tvheadend

    success "TVHeadend wurde installiert."

}

###############################################################################
# Enable TVHeadend service
###############################################################################

enable_tvheadend() {

    info "Aktiviere TVHeadend-Dienst..."

    systemctl enable tvheadend \
        || die "TVHeadend-Dienst konnte nicht aktiviert werden."

    success "TVHeadend-Dienst aktiviert."

}

###############################################################################
# Start TVHeadend service
###############################################################################

start_tvheadend() {

    info "Starte TVHeadend-Dienst..."

    systemctl start tvheadend \
        || die "TVHeadend-Dienst konnte nicht gestartet werden."

    success "TVHeadend-Dienst gestartet."

}

###############################################################################
# Verify TVHeadend service
###############################################################################

verify_tvheadend() {

    info "Prüfe TVHeadend-Dienst..."

    if systemctl is-active --quiet tvheadend; then
        success "TVHeadend läuft."
    else
        die "TVHeadend konnte nicht gestartet werden."
    fi

}

###############################################################################
# TVHeadend installation
###############################################################################

install_tvheadend_stack() {

    install_tvheadend
    enable_tvheadend
    start_tvheadend
    verify_tvheadend

}
