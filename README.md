
# qBittorrentManager

A series of shell scripts that achieves the following:
* on running `startqBittorrent.sh`
    - Starts a WireGuard VPN connection
    - Uses natpmpc to open a port on the VPN's network interface
    - Modifies the qBittorrent-nox configuration to use the listening port opened by natpmpc
    - Starts qBittorrent-nox
* on running `stopqBittorrent.sh`
    - Kills the running qBittorrent-nox process
    - Kills the running natpmpc script
    - Disconnects from the WireGuard VPN connection

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
