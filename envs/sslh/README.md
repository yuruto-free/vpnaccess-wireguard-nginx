# `.env` file for SSLH
Create an environment variable configuration file `.env` in the following format.

```sh
SERVER_URL=0.0.0.0
SERVER_PORT=443
SSH_HOST=10.1.2.2
SSH_PORT=22
HTTPS_HOST=10.1.2.2
HTTPS_PORT=443
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|SERVER_URL|External IP or domain name for docker host|
|SERVER_PORT|External port for docker host.|
|SSH_HOST|Internal IP or hostname for ssh server|
|SSH_PORT|Internal port for ssh server|
|HTTPS_HOST|Internal IP or hostname for https server|
|HTTPS_PORT|Internal port for https server|
