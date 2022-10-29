# Define environment variables
## `.env` file
Create an environment variable configuration file `.env` in the following format.

```sh
SERVER_ALLOWEDIPS_PEER_PublicServer=10.0.16.0/24
PUBLIC_SERVER_IP_ADDR=10.0.16.2
PUBLIC_SERVER_PORT=8080
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|SERVER_ALLOWEDIPS_PEER_&lt;peer name or number&gt;|Optional. The additional subnets you'd like to add. <br> Replace &lt;peer name or number&gt; with the name or number of peer (whichever is used in the `PEERS` var).|
|PUBLIC_SERVER_IP_ADDR|IP address of the public server on which the VPN client listens to Nginx|
|PUBLIC_SERVER_PORT|Port number of the public server on which the VPN client listens on Nginx|
