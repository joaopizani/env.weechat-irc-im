#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


"${DIR}/conf/ircconf-generate.sh"


WEECHAT_HOME="${HOME}/.weechat"
CONFDIR="${DIR}/conf"
CONFFILES=('alias.conf' 'aspell.conf' 'buffers.conf' 'irc.conf' 'logger.conf' 'plugins.conf' 'weechat.conf')

mkdir -p "${WEECHAT_HOME}"

for conffile in "${CONFFILES[@]}"; do
    ln -s -f -n "${CONFDIR}/${conffile}" "${WEECHAT_HOME}/${conffile}"
done

