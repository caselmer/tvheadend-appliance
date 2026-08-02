#!/usr/bin/env bash

###############################################################################
# Configure TVHeadend debconf
###############################################################################
configure_tvheadend_debconf() {
	info "Konfiguriere TVHeadend-Zugang..."
	debconf-set-selections <<EOF
	tvheadend tvheadend/admin_username string ${TVH_USERNAME}
	tvheadend tvheadend/admin_password password ${TVH_PASSWORD}
EOF

	success "TVHeadend-Zugang konfiguriert."
}

###############################################################################
# Install TVHeadend
###############################################################################

install_tvheadend() {

    info "Installiere TVHeadend..."

    configure_tvheadend_debconf
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
