#! /usr/bin/env bash

apikey="$XDG_DATA_HOME/openaigptkey.gpg"

if [ -e "$apikey" ]; then
	gpg -d "$apikey"
else
	$SUDO_ASKPASS "Keepass password prompt" | keepassxc-cli show -a Password "$KEEPASSDB" GPTAPI >"$XDG_DATA_HOME/openaigptkey"
	gpg -r adwaitadk@pm.me -e "$XDG_DATA_HOME/openaigptkey"
	rm "$XDG_DATA_HOME/openaigptkey"
fi
