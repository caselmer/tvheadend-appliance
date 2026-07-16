#!/usr/bin/env bash

update_system() {

echo

info "Aktualisiere Paketlisten..."
apt update
success "Paketlisten aktualisiert."

echo

info "Installiere Updates..."
apt -y upgrade
success "System ist aktuell."
}
