## PostUp/PostDown Sample Configuration
### PostUp
1. If you want to address translate an access coming to port 80 from 192.168.11.2 to 10.0.20.2 of VPN client, you would register the following command.

    ```sh
    iptables -t nat -A PREROUTING -p tcp -d 192.168.11.2 --dport 80 -j DNAT --to-destination 10.0.20.2:80
    ```

1. Similarly, to address translate an access coming to port 8888 from 192.168.11.3 to 10.0.20.2 of VPN client, you would register the following command.

    ```sh
    iptables -t nat -A PREROUTING -p tcp -d 192.168.11.3 --dport 8888 -j DNAT --to-destination 10.0.20.2:8888
    ```

1. Finally, save the above command in `conf.up.d/02-routing-lan-access.conf`. In other words, save the following command to `conf.up.d/02-routing-lan-access.conf`.

    ```sh
    iptables -t nat -A PREROUTING -p tcp -d 192.168.11.2 --dport 80 -j DNAT --to-destination 10.0.20.2:80
    iptables -t nat -A PREROUTING -p tcp -d 192.168.11.3 --dport 8888 -j DNAT --to-destination 10.0.20.2:8888
    ```

### PostDown
Save the following command in `conf.down.d/02-routing-lan-access.conf`.

```sh
iptables -t nat -D PREROUTING -p tcp -d 192.168.11.2 --dport 80 -j DNAT --to-destination 10.0.20.2:80
iptables -t nat -D PREROUTING -p tcp -d 192.168.11.3 --dport 8888 -j DNAT --to-destination 10.0.20.2:8888
```
