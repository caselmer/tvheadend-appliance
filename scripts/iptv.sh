#!/usr/bin/env bash

#
# TVHeadend Appliance
# IPTV configuration
#

###############################################################################
# TVHeadend API endpoints
###############################################################################

readonly TVH_API_NETWORK_GRID="mpegts/network/grid"
readonly TVH_API_NETWORK_CREATE="mpegts/network/create"

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

    info "Prüfe IPTV-Netzwerk ..."

    local json

    json="$(
        tvh_api_get "$TVH_API_NETWORK_GRID"
    )"

    printf '%s\n' "$json"

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
