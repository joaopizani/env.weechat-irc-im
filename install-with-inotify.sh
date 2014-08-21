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
AUTOSTART_DIR="${HOME}/.config/autostart"
mkdir -p "${AUTOSTART_DIR}"
ln -s -f -n "${DIR}/inotify-daemon.desktop"           "${AUTOSTART_DIR}/inotify-daemon.desktop"
ln -s -f -n "${DIR}/away-watch-xscreensaver.desktop"  "${AUTOSTART_DIR}/away-watch-xscreensaver.desktop"

start-stop-daemon --exec "${BINHOME}/inotify-daemon" --start
"${BINHOME}/away-watch-xscreensaver" 1> /dev/null 2> /dev/null < /dev/null & disown %?'away-watch-xscreensaver'
