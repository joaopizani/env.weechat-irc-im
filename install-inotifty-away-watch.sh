#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-basic.sh"

git submodule update --init --recursive --remote
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'

BINHOME="${HOME}/bin"
mkdir -p "${BINHOME}"
ln -s -f -n "${DIR}/inotify-daemon/inotify-daemon"  "${BINHOME}/inotify-daemon"
ln -s -f -n "${DIR}/away-watch-xscreensaver.sh"     "${BINHOME}/away-watch-xscreensaver"
hash -r

# GNOME-based
GNOME_AUTOSTART="${HOME}/.config/autostart"
HERE_AUTOSTART="${DIR}/autostart"
mkdir -p "${GNOME_AUTOSTART}"
ln -s -f -n "${HERE_AUTOSTART}/inotify-daemon.desktop"           "${GNOME_AUTOSTART}/inotify-daemon.desktop"
ln -s -f -n "${HERE_AUTOSTART}/away-watch-xscreensaver.desktop"  "${GNOME_AUTOSTART}/away-watch-xscreensaver.desktop"

start-stop-daemon --exec "${BINHOME}/inotify-daemon" --start
start-stop-daemon --exec "${BINHOME}/away-watch-xscreensaver" --start

