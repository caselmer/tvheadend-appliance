#!/usr/bin/env bash

###############################################################################
# TVHeadend Appliance
# TVHeadend HTTP API
#
# Diese Bibliothek kapselt sämtliche HTTP-Kommunikation mit TVHeadend.
#
# Öffentliche Funktionen:
#
#   tvh_api_wait
#   tvh_api_get
#   tvh_api_post
#
# Direkte curl-Aufrufe außerhalb dieser Datei sind nicht erlaubt.
###############################################################################

###############################################################################
# Private helper
###############################################################################

_tvh_api_url() {

    printf 'http://%s:%s/api' \
        "$TVH_HOST" \
        "$TVH_PORT"

}

_tvh_curl() {

    local curl_args=(
        --silent
        --show-error
        --fail
        --location
        --connect-timeout 5
        --max-time 30
    )

    if [[ -n "${TVH_USERNAME:-}" ]]; then
        curl_args+=(
            --user
            "${TVH_USERNAME}:${TVH_PASSWORD}"
        )
    fi

    curl_args+=("$@")

    curl "${curl_args[@]}"

}

###############################################################################
# Wait until TVHeadend is reachable
###############################################################################

tvh_api_wait() {

    local api_url
    local timeout=60

    api_url="$(_tvh_api_url)/serverinfo"

    while (( timeout > 0 ))
    do
        if _tvh_curl "$api_url" >/dev/null; then
            return 0
        fi

        sleep 1
        ((timeout--))
    done

    return 1

}


###############################################################################
# HTTP GET
###############################################################################

tvh_api_get() {

    local endpoint="${1:?Missing endpoint}"

    _tvh_curl \
        "$(_tvh_api_url)/${endpoint}"

}

###############################################################################
# HTTP POST
###############################################################################

tvh_api_post() {

    local endpoint="${1:?Missing endpoint}"
    local data="${2:?Missing data}"

    _tvh_curl \
        --data "$data" \
        "$(_tvh_api_url)/${endpoint}"

}
