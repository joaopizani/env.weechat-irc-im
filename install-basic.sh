#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

BITLBEE_PREFIX_DEFAULT="/"
BITLBEE_PREFIX="${1:-"${BITLBEE_PREFIX_DEFAULT}"}"
BITLBEE_ETCDIR="${BITLBEE_PREFIX}/etc/bitlbee"

WEECHAT_HOME="${HOME}/.weechat"
CONFDIR="${DIR}/conf"
CONFFILES=('alias.conf' 'aspell.conf' 'buffers.conf' 'irc.conf' 'logger.conf' 'plugins.conf' 'weechat.conf')


sudo apt-get install weechat

"${DIR}/conf/ircconf-generate.sh"

mkdir -p "${WEECHAT_HOME}"
for conffile in "${CONFFILES[@]}"; do
    ln -s -f -n "${CONFDIR}/${conffile}" "${WEECHAT_HOME}/${conffile}"
done

LNCMD="ln -s -f -n ${DIR}/bitlbee.conf ${BITLBEE_ETCDIR}/bitlbee.conf"
${LNCMD} || sudo ${LNCMD}
