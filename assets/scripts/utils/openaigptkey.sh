#! /usr/bin/env bash

apikey="$XDG_DATA_HOME/secrets/openaigptkey.gpg"
directory="$XDG_DATA_HOME/secrets"

if [ ! -d "$directory" ]; then
	mkdir -p "$directory"
fi

if [ -e "$apikey" ]; then
	gpg -d "$apikey"
else
	$SUDO_ASKPASS "Keepass password prompt" | keepassxc-cli show -a Password "$KEEPASSDB" GPTAPI >"$XDG_DATA_HOME/secrets/openaigptkey"
	gpg -r adwaitadk@pm.me -e "$XDG_DATA_HOME/secrets/openaigptkey"
	rm "$XDG_DATA_HOME/secrets/openaigptkey"
fi
