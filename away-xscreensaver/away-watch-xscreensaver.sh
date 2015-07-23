#!/usr/bin/env bash

STATUSFILE_DEFAULT="~/.available"
STATUSFILE="${1:-"${STATUSFILE_DEFAULT}"}"

# Read xscreensaver's state
xscreensaver-command -watch|
while read STATUS; do
    case "$STATUS" in
        LOCK*)
            rm "${STATUSFILE}"
        ;;
        UNBLANK*)
            touch "${STATUSFILE}"
        ;;
    esac
done
