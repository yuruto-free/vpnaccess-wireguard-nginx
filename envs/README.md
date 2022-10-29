# Define environment variables
## `.env` file
Create an environment variable configuration file `.env` in the following format.

```sh
PUBLIC_SERVER_IP_ADDR=10.0.16.3
PUBLIC_SERVER_PORT=8080
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|PUBLIC_SERVER_IP_ADDR|IP address of the public server on which the VPN client listens to Nginx|
|PUBLIC_SERVER_PORT|Port number of the public server on which the VPN client listens on Nginx|
