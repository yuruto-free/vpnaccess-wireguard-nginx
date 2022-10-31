# Define environment variables for WireGuard container
## `.env` file for WireGuard
Create an environment variable configuration file `.env` in the following format.

```sh
SERVERURL=example.vpn.com
SERVERPORT=51820
PEERS=PublicServer,LocalServer,myPhone
PEERDNS=auto
INTERNAL_SUBNET=10.1.2.0/24
MTU=1380
KEEP_ALIVE=10
ALLOWEDIPS=10.1.2.0/24
SERVER_ALLOWEDIPS_PEER_PublicServer=10.0.16.0/24
SERVER_ALLOWEDIPS_PEER_LocalServer=10.0.20.0/24
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|SERVERURL|Optional. External IP or domain name for docker host|
|SERVERPORT|Optional. External port for docker host.|
|PEERS|Optional. Number of peers to create confs for. <br> Can also be a list of names: `PublicServer,myPC,myPhone,myTablet` (alphanumeric only)|
|PEERDNS|Optional. DNS server set in peer/client configs.|
|INTERNAL_SUBNET|Optional. Internal subnet for the wireguard and server and peers.|
|MTU|Maximum datagram size that can be transferred in one communication.|
|KEEP_ALIVE|Interval of communication confirmation.|
|ALLOWEDIPS|Optional. The IPs/Ranges that the peers will be able to reach using the VPN connection.|
|SERVER_ALLOWEDIPS_PEER_&lt;peer name or number&gt;|Optional. The additional subnets you'd like to add. <br> Replace &lt;peer name or number&gt; with the name or number of peer (whichever is used in the `PEERS` var).|
