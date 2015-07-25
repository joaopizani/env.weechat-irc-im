#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

SUBMODULE_NAME="bitlbee-facebook"
SUBMODULE="${DIR}/${SUBMODULE_NAME}"

# assume existence of submodule, must have been checked-out by install-complete or by hand
BITLBEE_PREFIX_DEFAULT="${HOME}/build/bitlbee"
BITLBEE_PREFIX="$(readlink -m "${1:-"${BITLBEE_PREFIX_DEFAULT}"}")"

BITLBEE_PKGCFG_DEFAULT="${BITLBEE_PREFIX}/lib/pkgconfig"
BITLBEE_PKGCFG="$(readlink -m "${2:-"${BITLBEE_PKGCFG_DEFAULT}"}")"

pushd "${SUBMODULE}"
PKG_CONFIG_PATH="${BITLBEE_PKGCFG}" ./autogen.sh --prefix="${BITLBEE_PREFIX}"
make
make install
make distclean
popd

