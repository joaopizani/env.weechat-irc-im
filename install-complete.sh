#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-basic.sh"

git submodule update --init --recursive --remote
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'

"${DIR}/inotify-msgs/install.sh"
"${DIR}/away-xscreensaver/install.sh"


BITLBEE_SRC_VER="3.4.1"
BITLBEE_PREFIX="${HOME}/build/bitlbee"
BITLBEE_BUILDDIR_ROOT="/tmp"

"${DIR}/bitlbee/install.sh" "${BITLBEE_SRC_VER}" "${BITLBEE_PREFIX}" "${BITLBEE_BUILDDIR_ROOT}"

