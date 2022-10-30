# VPN Access used by WireGuard and Nginx

## Preparation
1. Create `.env` file in `./envs` with reference to [the README.md](./envs/README.md).
1. Create `.env` file in `./envs/wireguard` with reference to [the README.md](./envs/wireguard/README.md).
1. Create `.env` file in `./envs/nginx` with reference to [the README.md](./envs/nginx/README.md).
1. Create `cli.ini` file in `./nginx` with reference to [the sample.cli.ini](./nginx/sample.cli.ini).
1. Check `.env` and `cli.ini` files exist.

    ```sh
    ls envs/.* envs/*/.* nginx/cli.ini | grep "\.env$\|cli.ini"
    # results:
    #   envs/.env
    #   envs/nginx/.env
    #   envs/wireguard/.env
    #   nginx/cli.ini
    ```

1. Execute the following command to open UDP port.

    ```sh
    # Replace your-wireguard-serverport to value of SERVERPORT in ./envs/wireguard/.env
    sudo ufw allow your-wireguard-serverport/udp
    # reload
    sudo ufw reload
    ```

1. Give the current user execute permissions.

    ```sh
    chmod +x wrapper.sh
    ```

1. Update `PUID` and `PGID` in `docker-compose.yml`. These IDs can be obtained by executing the following command.

    ```sh
    id ${USER}
    # output example
    # uid=1000(yuruto) gid=1000(yuruto) groups=1000(yuruto)
    # PUID = 1000 (= uid), PGID = 1000 (= gid)
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
