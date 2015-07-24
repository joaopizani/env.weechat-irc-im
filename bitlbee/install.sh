#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

BITLBEE_SRC_VER_DEFAULT="3.4.1"
BITLBEE_SRC_VER="${1:-"${BITLBEE_SRC_VER_DEFAULT}"}"

BITLBEE_SRC_SITE="http://get.bitlbee.org/src"

BITLBEE_SRC_FILENAME="bitlbee-${BITLBEE_SRC_VER}.tar.gz"
BITLBEE_SRC_URL="${BITLBEE_SRC_SITE}/${BITLBEE_SRC_FILENAME}"

BITLBEE_PREFIX_DEFAULT="${HOME}/build/bitlbee"
BITLBEE_PREFIX="$(readlink -m "${2:-"${BITLBEE_PREFIX_DEFAULT}"}" )"
mkdir -p "${BITLBEE_PREFIX}"
BITLBEE_ETCDIR="${BITLBEE_PREFIX}/etc/bitlbee"

BUILDDIR_ROOT_DEFAULT="/tmp"
BUILDDIR_ROOT="$(readlink -m "${3:-"${BUILDDIR_ROOT_DEFAULT}"}" )"
BUILDDIR="${BUILDDIR_ROOT}/bitlbee-build"
mkdir -p "${BUILDDIR}"

BINDIR="${HOME}/bin"
mkdir -p "${BINDIR}"

sudo apt-get install libglib2.0-dev libotr5-dev libgnutls-dev
sudo easy_install Skype4Py

wget "${BITLBEE_SRC_URL}" -O "${BUILDDIR}/${BITLBEE_SRC_FILENAME}"
mkdir -p "${BUILDDIR}/src"
tar -xf "${BUILDDIR}/${BITLBEE_SRC_FILENAME}" -C "${BUILDDIR}/src" --strip-components=1

pushd "${BUILDDIR}/src"
./configure --prefix="${BITLBEE_PREFIX}" --otr=1 --skype=1 --ssl=gnutls --strip=0
make -j
make install
make install-etc
make install-dev
popd

LNCMD="ln -s -f -n ${DIR}/bitlbee.conf ${BITLBEE_ETCDIR}/bitlbee.conf"
${LNCMD} || sudo ${LNCMD}

ln -s -f -n "${BITLBEE_PREFIX}/sbin/bitlbee" "${BINDIR}/bitlbee"


rm -rf "${BUILDDIR}"

