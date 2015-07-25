#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"


sudo apt-get install weechat{,-{core,curses,dbg,dev,doc,plugins}}

WEECHAT_HOME="${HOME}/.weechat"
CONFDIR="${DIR}/conf"
CONF_BEFORE_PLUGINS=('alias' 'aspell' 'buffers' 'irc' 'logger')
CONF_AFTER_PLUGINS=('plugins' 'weechat')

"${DIR}/conf/ircconf-generate.sh"
"${DIR}/conf/loggerconf-generate.sh"

mkdir -p "${WEECHAT_HOME}"
for f in "${CONF_BEFORE_PLUGINS[@]}"; do ln -s -f -n "${CONFDIR}/${f}.conf" "${WEECHAT_HOME}/${f}.conf"; done

SCRIPT_COMMAND="/script install "
while read -u9 PLUG; do SCRIPT_COMMAND+="${PLUG} "; done 9< "${DIR}/pluginlist.txt"
weechat -a -s -r "${SCRIPT_COMMAND}"

for f in "${CONF_AFTER_PLUGINS[@]}"; do ln -s -f -n "${CONFDIR}/${f}.conf" "${WEECHAT_HOME}/${f}.conf"; done

