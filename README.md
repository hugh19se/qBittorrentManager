
# qBittorrentManager

A series of shell scripts to start/stop a wireguard connection, port forwarding and a qBittorrent-nox instance

## Prerequisites
- Wireguard
- qbittorrent-nox
- Root access (Due to the scripts starting/stopping wireguard connections, the scripts have to be ran as the root user)

## Setup
1) By default the scripts expect your wireguard config file to be at `/etc/wireguard/portForwarding.conf`. This can be changed in the `subScripts/startWireguard.sh` and `subScripts/stopWireguard.sh` files.

2) All the shell scripts require execute permissions to be ran. This can be done manually or by running the below command at the repo's main folder
```
find . -name "*.sh" -exec chmod +x {} \;
```

From there, the `startqBittorrent.sh` and `stopqBittorrent.sh` scripts can be ran. The scripts only output information on error, all STDOUT information is redirected to a `logs` folder that is created in the repo's main folder.
