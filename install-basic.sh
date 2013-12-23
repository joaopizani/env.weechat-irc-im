#!/usr/bin/env bash

REL_SRC="${BASH_SOURCE[0]}"
CANONICAL_SRC=$(readlink -f "$REL_SRC")
DIR="$(cd -P "$(dirname $CANONICAL_SRC)" && pwd)"


WEECHAT_HOME="${HOME}/.weechat"
CONFDIR="${DIR}/conf"
CONFFILES=('alias.conf' 'aspell.conf' 'buffers.conf' 'irc.conf' 'logger.conf' 'plugins.conf' 'weechat.conf')

mkdir -p "${WEECHAT_HOME}"

for conffile in "${CONFFILES[@]}"; do
    ln -s -f "${CONFDIR}/${conffile}" "${WEECHAT_HOME}/${conffile}"
done

