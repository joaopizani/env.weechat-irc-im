#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


WEECHAT_HOME="${HOME}/.weechat"
CONFDIR="${DIR}/conf"
CONFFILES=('alias' 'aspell' 'buffers' 'irc' 'logger' 'plugins' 'weechat')

"${DIR}/conf/ircconf-generate.sh"
"${DIR}/conf/loggerconf-generate.sh"

mkdir -p "${WEECHAT_HOME}"
for f in "${CONFFILES[@]}"; do ln -s -f -n "${CONFDIR}/${f}.conf" "${WEECHAT_HOME}/${f}.conf"; done


BITLBEE_PREFIX_DEFAULT="${HOME}/build/bitlbee"
BITLBEE_PREFIX="$(readlink -m "${1:-"${BITLBEE_PREFIX_DEFAULT}"}" )"

BITLBEE_SRC_VER_DEFAULT="3.2.2"
BITLBEE_SRC_VER="${2:-"${BITLBEE_SRC_VER_DEFAULT}"}"

BITLBEE_BUILDDIR_ROOT_DEFAULT="/tmp"
BITLBEE_BUILDDIR_ROOT="$(readlink -m "${3:-"${BITLBEE_BUILDDIR_ROOT_DEFAULT}"}" )"

"${DIR}/install-bitlbee.sh" "${BITLBEE_SRC_VER}" "${BITLBEE_PREFIX}" "${BITLBEE_BUILDDIR_ROOT}"

