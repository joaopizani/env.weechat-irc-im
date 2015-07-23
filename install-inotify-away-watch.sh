#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

"${DIR}/install-basic.sh"

git submodule update --init --recursive --remote
git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git checkout $branch'

"${DIR}/inotify-msgs/install.sh"
"${DIR}/away-xscreensaver/install.sh"

