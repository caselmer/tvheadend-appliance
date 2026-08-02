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
        "$TVH_HTTP_PORT"

}

###############################################################################
# HTTP status helper
#
# Liefert ausschließlich den HTTP-Statuscode zurück.
###############################################################################

_tvh_http_status() {

    local url="${1:?Missing URL}"

    curl \
        --silent \
        --output /dev/null \
        --write-out '%{http_code}' \
        --connect-timeout 5 \
        --max-time 30 \
        "$url" \
        || printf '000'

}

###############################################################################
# Zentraler curl-Wrapper
###############################################################################

_tvh_curl() {

    local curl_args=(
        --silent
        --show-error
        --fail
        --location
        --connect-timeout 5
        --digest
        --max-time 30
    )

    if [[ -n "${TVH_USERNAME:-}" ]] && [[ -n "${TVH_PASSWORD:-}" ]]; then
        curl_args+=(
               --user
               "${TVH_USERNAME}:${TVH_PASSWORD}"
           )
    fi

    curl "${curl_args[@]}" "$@"

}

###############################################################################
# Wait until TVHeadend is reachable
###############################################################################

tvh_api_wait() {

    info "Warte auf TVHeadend..."

    local timeout=60
    local api_url
    local http_code

    api_url="$(_tvh_api_url)/serverinfo"

    while (( timeout > 0 ))
    do

        http_code="$(_tvh_http_status "$api_url")"

        case "$http_code" in

            200|401)
                success "TVHeadend ist erreichbar."
                return 0
                ;;

        esac

        sleep 1
        ((timeout--))

    done

    die "TVHeadend konnte nicht erreicht werden."

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
