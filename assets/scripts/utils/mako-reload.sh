#!/usr/bin/env sh

makoctl reload
# to test a 'high' urgency notification add '-u critical '
notify-send -a "Test notif app" -t 5000 "Here is some summary" "the config has been reloaded!"
