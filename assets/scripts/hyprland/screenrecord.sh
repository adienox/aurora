#!/usr/bin/env bash
VIDEO="$XDG_VIDEOS_DIR/recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4"

fuser -sk -SIGINT "$0"
test "$1" = off && exit 0
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -enx "$0" "$0" "$@" || :
exec wf-recorder -f "$VIDEO"
