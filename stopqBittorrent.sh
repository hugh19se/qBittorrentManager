#!/bin/bash

#Ensure user is running as root
if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root\nThis is required to manage the wireguard connection\n"
   exit 1
fi

#Change directory to same as script path
cd "$(dirname "$0")"

#Add stopping message to log files
stopMessage="### Stopping at $(date) ###"

echo $stopMessage >> ./logs/wireguard.out
echo $stopMessage >> ./logs/wireguard.err

echo $stopMessage >> ./logs/portForward.out
echo $stopMessage >> ./logs/portForward.err

echo $stopMessage >> ./logs/qBittorrent.out
echo $stopMessage >> ./logs/qBittorrent.err

#Import environment variables from start script
source ./processInfo.env

#Stop qBittorrent-nox
kill -9 $qBittorrentPID

#Stop port forwarding script
kill -9 $portForwardingPID

#Stop VPN connection
#For some reason wg-quick outputs to STDERR
nohup ./subScripts/stopWireguard.sh >> ./logs/wireguard.err 2>> ./logs/wireguard.out < /dev/null
