# VPN Access used by WireGuard and SSLH

## Preparation
Create `.env` file in `./envs/wireguard` with reference to [the README.md](./envs/wireguard/README.md).

## Build
Run the following command and create several images.

```sh
docker-compose build --no-cache
```

## Start
Enter the following command to start the container.

```sh
docker-compose up -d
```
