#!/usr/bin/env bash
VIDEO="$XDG_VIDEOS_DIR/recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4"

if pgrep -x wf-recorder >/dev/null; then
	kill $(pgrep -x wf-recorder)
else
	wf-recorder -f "$VIDEO"
fi
