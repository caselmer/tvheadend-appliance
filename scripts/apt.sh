#!/usr/bin/env bash

update_system() {

echo
echo "==> Paketlisten aktualisieren"

apt update

echo
echo "==> Pakete aktualisieren"

apt -y upgrade

}
