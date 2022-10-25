# `.env` file for WireGuard
Create an environment variable configuration file `.env` in the following format.

```sh
SERVERURL=example.vpn.con
SERVERPORT=51820
PEERS=1
PEERDNS=auto
INTERNAL_SUBNET=10.1.2.0/24
ALLOWEDIPS=10.1.2.0/24
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|SERVERURL|Optional. External IP or domain name for docker host|
|SERVERPORT|Optional. External port for docker host.|
|PEERS|Optional. Number of peers to create confs for. <br> Can also be a list of names: `myPC,myPhone,myTablet` (alphanumeric only)|
|PEERDNS|Optional. DNS server set in peer/client configs.|
|INTERNAL_SUBNET|Optional. Internal subnet for the wireguard and server and peers.|
|ALLOWEDIPS|Optional. The IPs/Ranges that the peers will be able to reach using the VPN connection.|
