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
    local response
    local uuid
    local conf
    local data

    json="$(
        tvh_api_get "$TVH_API_NETWORK_GRID?limit=50"
    )" || die "IPTV-Netzwerk konnte nicht abgefragt werden."

    if jq -e \
        --arg name "$IPTV_NAME" \
        '.entries[]? | select(.networkname == $name)' \
        >/dev/null <<< "$json"; then

        success "IPTV-Netzwerk bereits vorhanden."

        return 0
    fi

    info "Lege IPTV-Netzwerk an..."

    conf="$(
        jq -cn \
            --arg name "$IPTV_NAME" \
            --arg url "$IPTV_URL" \
            --argjson priority "$IPTV_PRIORITY" \
            '{
                enabled: true,
                networkname: $name,
                url: $url,
                priority: $priority,
                scan_create: true
            }'
    )" || die "IPTV-Konfiguration konnte nicht erstellt werden."

    data="class=iptv_network&conf=$(printf '%s' "$conf" | jq -sRr @uri)"

    response="$(
        tvh_api_post "$TVH_API_NETWORK_CREATE" "$data"
    )" || die "IPTV-Netzwerk konnte nicht angelegt werden."

    uuid="$(jq -r '.uuid // empty' <<< "$response")"

    if [[ -z "$uuid" ]]; then
        die "TVHeadend hat keine UUID für das IPTV-Netzwerk zurückgegeben."
    fi

    success "IPTV-Netzwerk angelegt."

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
