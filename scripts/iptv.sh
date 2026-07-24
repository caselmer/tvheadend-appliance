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
