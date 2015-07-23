#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-basic.sh"

git submodule update --init --recursive --remote
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'

ln -s -f -n "${DIR}/inotify-daemon/inotify-daemon"  "${BINHOME}/inotify-daemon"
hash -r

GNOME_AUTOSTART="${HOME}/.config/autostart"
mkdir -p "${GNOME_AUTOSTART}"
ln -s -f -n "${DIR}/autostart/inotify-daemon.desktop" "${GNOME_AUTOSTART}/inotify-daemon.desktop"

start-stop-daemon --exec "${BINHOME}/inotify-daemon" --start

