#!/usr/bin/env bash

#
# TVHeadend Appliance
# IPTV configuration
#

configure_iptv() {

    tvh_api_wait

    create_iptv_network

    configure_m3u

    trigger_scan

}

###############################################################################
# IPTV network
###############################################################################

create_iptv_network() {

    info "IPTV-Netzwerk wird vorbereitet..."

    # TODO:
    # IPTV-Netzwerk über TVHeadend API anlegen.

    success "IPTV-Netzwerk vorbereitet."

}

###############################################################################
# M3U
###############################################################################

configure_m3u() {

    info "M3U-Konfiguration wird vorbereitet..."

    # TODO:
    # M3U-Quelle konfigurieren.

    success "M3U-Konfiguration übersprungen."

}

###############################################################################
# Scan
###############################################################################

trigger_scan() {

    info "Sendersuchlauf wird vorbereitet..."

    # TODO:
    # Scan starten.

    success "Sendersuchlauf übersprungen."

}
