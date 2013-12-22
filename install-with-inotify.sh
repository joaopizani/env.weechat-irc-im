#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"

./install-basic.sh

mkdir -p "${HOME}/bin"
ln -s -f "${DIR}/inotify-daemon/inotify-daemon" "${HOME}/bin/inotify-daemon"
hash -r

# GNOME-based
AUTOSTART_DIR="${HOME}/.config/autostart"
mkdir -p ${AUTOSTART_DIR}
cp "${DIR}/inotify-daemon.desktop" "${AUTOSTART_DIR}/inotify-daemon.desktop"

