# VPN Access used by WireGuard and SSLH

## Preparation
1. Create `.env` file in `./envs/wireguard` with reference to [the README.md](./envs/wireguard/README.md).
1. Create `.env` file in `./envs/sslh` with reference to [the README.md](./envs/sslh/README.md).
1. Execute the following command to open UDP port and TCP port.

    ```sh
    # Replace your-wireguard-serverport to value of SERVERPORT in ./envs/wireguard/.env
    sudo ufw allow your-wireguard-serverport/udp
    # Replace your-sslh-serverport to value of SERVER_PORT in ./envs/sslh/.env
    sudo ufw allow your-sslh-serverport/tcp
    # reload
    sudo ufw reload
    ```

1. Make sure that you have the current file permissions.

    ```sh
    chmod +x wrapper.sh # Give the current user execute permissions.
    ```

## Build
Run the following command and create several images.

```sh
./wrapper.sh build
```

## Start
Enter the following command to start the container.

```sh
./wrapper.sh start
```

## Check status/log
Execute the following command.

```sh
# show process status
./wrapper.sh ps

# show log
./wrapper.sh logs
```
