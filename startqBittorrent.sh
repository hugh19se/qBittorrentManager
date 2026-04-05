#!/bin/bash

#Ensure user is running as root
if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root\nThis is required to manage the wireguard connection\n"
   exit 1
fi

#Change directory to same as script path
cd "$(dirname "$0")"

#Create logs folder if it doesn't already exist
mkdir -p logs

#Create log files / Clear log files from previous run
startMessage="### Starting at $(date) ###"

echo $startMessage > ./logs/wireguard.out
echo $startMessage > ./logs/wireguard.err

echo $startMessage > ./logs/portForward.out
echo $startMessage > ./logs/portForward.err

echo $startMessage > ./logs/qBittorrent.out
echo $startMessage > ./logs/qBittorrent.err

echo '' > ./processInfo.env

#Start VPN connection
#For some reason wg-quick outputs to STDERR
nohup ./subScripts/startWireguard.sh >> ./logs/wireguard.err 2>> ./logs/wireguard.out < /dev/null

#Start port forwarding script and get PID
portForwardingPID=$(nohup ./subScripts/startPortForwarding.sh >> ./logs/portForward.out 2>> ./logs/portForward.err < /dev/null & echo $!)

#Get port from nohup output file
port=''
while [[ $port == "" ]]
do
	port=$(grep -E "public port [0-9]+ protocol" ./logs/portForward.out | tail -1 | grep -o -E "[0-9]+" | head -1)
done

#Update port in qBittorrent config
sed -i 's,Session\\Port\=.*,Session\\Port\='"$port"',g' ~/.config/qBittorrent/qBittorrent.conf

#Start qBittorrent-nox and get PID
qBittorrentPID=$(nohup qbittorrent-nox >> ./logs/qBittorrent.out 2>> ./logs/qBittorrent.err < /dev/null & echo $!)

#Output information
printf "portForwardingPID=${portForwardingPID}\nport=${port}\nqBittorrentPID=${qBittorrentPID}\n" > ./processInfo.env
#cat processInfo.env
