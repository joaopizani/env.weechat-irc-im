#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

LOGDIR_DEFAULT_="${HOME}/comm/irclogs/weechat"
read -e -p "Which logging directory to use (default = ${LOGDIR_DEFAULT_}) > " LOGDIR_READ_
LOGDIR_="${LOGDIR_READ_:-${LOGDIR_DEFAULT_}}"
LOGDIR="$(readlink -m "${LOGDIR_}")"
mkdir -p "${LOGDIR}"

cat <<EOF > "${DIR}/logger.conf"
#
# logger.conf -- weechat v1.0-dev
#

[look]
backlog = 10

[color]
backlog_end = default
backlog_line = default

[file]
auto_log = on
flush_delay = 30
info_lines = off
mask = "\$plugin.\$name.%Y-%m.log"
name_lower_case = on
nick_prefix = ""
nick_suffix = ">>"
path = "${LOGDIR}"
replacement_char = "_"
time_format = "%Y-%m-%d %H:%M:%S"

[level]

[mask]
EOF

