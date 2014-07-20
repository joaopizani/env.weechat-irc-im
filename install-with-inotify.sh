#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-basic.sh"

git submodule update --init --recursive --remote
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'
mkdir -p "${HOME}/bin"
ln -s -f -n "${DIR}/inotify-daemon/inotify-daemon" "${HOME}/bin/inotify-daemon"
hash -r

# GNOME-based
AUTOSTART_DIR="${HOME}/.config/autostart"
mkdir -p "${AUTOSTART_DIR}"
ln -s -f -n "${DIR}/inotify-daemon.desktop" "${AUTOSTART_DIR}/inotify-daemon.desktop"

start-stop-daemon --exec "${HOME}/bin/inotify-daemon" --start

