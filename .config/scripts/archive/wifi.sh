#! /bin/bash

# Base script from shmalebx9
# https://github.com/shmalebx9/boethius

# For dynamic declaration of interface name
#INTERFACE=$(cat /proc/net/wireless | awk -F ':' 'NR > 2 {print $1}')

# For explicit declaration of interface name
INTERFACE="wlan0"

theme="config"
dir="$HOME/.config/rofi/launchers"

splitSelect() {
  set $SELECT
	key_mgmnt="$1"
	SSID="$2"
}

switchNetwork() {
	wpa_cli -i $INTERFACE enable_network $NETNUMBER
	wpa_cli -i $INTERFACE select_network $NETNUMBER
  wpa_cli -i $INTERFACE save_config
}

notSaved() {
  echo "SSID is $SSID"
  echo "key_mgmnt is $key_mgmnt"
  NETNUMBER=$(wpa_cli -i $INTERFACE add_network)
  wpa_cli -i $INTERFACE set_network $NETNUMBER ssid "\"$SSID\""

  if [[ $key_mgmnt == "NONE" ]]; then
	    open_net_connect
	  else
	    psk_network_connect
  fi
}

open_net_connect() {
	wpa_cli -i $INTERFACE set_network 0 key_mgmt NONE
  switchNetwork
}

psk_network_connect() {
	psk=$(rofi -theme $dir/"$theme" -dmenu -p "Password for $SSID")
	wpa_cli -i $INTERFACE set_network $NETNUMBER psk "\"$psk\""
  switchNetwork
}

saved() {
	NETNUMBER=$(echo "$SAVED" | awk '/'$SSID'/{print $1}')
	echo "netnumber is $NETNUMBER"
  switchNetwork
}

scanNetwork(){
  fulllist=$(wpa_cli -i "$INTERFACE" scan >/dev/null; sleep 1; wpa_cli -i "$INTERFACE" scan_results)
}

scanNetwork
c=0
until grep '[0-9]' <<< $fulllist ; do
  scanNetwork
	echo "scanning"
  ((c=c+1))
  if [ $c -gt 3 ]; then
    exit 1
  fi
done

SAVED=$(wpa_cli list_network | sed '1,2d')
SELECT=$(echo "$fulllist" | awk -F "\t" 'NR > 1 {gsub ("ESS]", "PSK"); split($4, arr, "[[-]"); print arr[2]"/"arr[5] "\t" $5}' | rofi -theme $dir/"$theme" -i -dmenu -p 'Select Network' )

if [[ -z $SELECT ]]; then
  echo "none selected"
  exit 0
fi

splitSelect

if [[ -z $(echo "$SAVED" | grep "$SSID") ]]; then
	echo "network not saved"
  notSaved
		else
	echo "network saved"
  saved
fi
