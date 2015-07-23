#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

sudo apt-get install xscreensaver

BINHOME="${HOME}/bin"
mkdir -p "${BINHOME}"

ln -s -f -n "${DIR}/away-watch-xscreensaver.sh" "${BINHOME}/away-watch-xscreensaver"
hash -r


GNOME_AUTOSTART="${HOME}/.config/autostart"
mkdir -p "${GNOME_AUTOSTART}"

ln -s -f -n "${DIR}/away-watch-xscreensaver.desktop" "${GNOME_AUTOSTART}/away-watch-xscreensaver.desktop"

start-stop-daemon --exec "${BINHOME}/away-watch-xscreensaver" --start

