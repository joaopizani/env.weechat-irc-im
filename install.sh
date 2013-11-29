#!/usr/bin/env bash

REL_SRC=${BASH_SOURCE[0]}
CANONICAL_SRC=$(readlink -f $REL_SRC)
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"


WEECHAT_HOME="${HOME}/.weechat"
CONFFILES=('alias.conf' 'aspell.conf' 'buffers.conf' 'irc.conf' 'logger.conf' 'plugins.conf' 'weechat.conf')

for conffile in "${CONFFILES[@]}"; do
    ln -s -f "${DIR}/${conffile}" "${WEECHAT_HOME}/${conffile}"
done


mkdir -p "${HOME}/bin"
ln -s -f "${DIR}/inotify-daemon/inotify-daemon" "${HOME}/bin/inotify-daemon"
hash -r

# GNOME-based
AUTOSTART_DIR="${HOME}/.config/autostart"
mkdir -p ${AUTOSTART_DIR}
cp "${DIR}/inotify-daemon.desktop" "${AUTOSTART_DIR}/inotify-daemon.desktop"

