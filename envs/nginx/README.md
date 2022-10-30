# Define environment variables for Nginx
## `.env` file for Nginx
Create an environment variable configuration file `.env` in the following format.

```sh
BASE_DOMAIN_NAME=example.com
VHOST_NAME=www.example.com
SSL_CERT_PATH=/etc/nginx/default_certs/default.crt
SSL_CERTKEY_PATH=/etc/nginx/default_certs/default.key
SSL_STAPLING_VERIFY=off
SSL_TRUSTED_CERTIFICATE_PATH=/etc/nginx/default_certs/default.crt
PUBLIC_SERVER_IP_ADDR=10.0.16.3
PUBLIC_SERVER_PORT=8080
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|BASE_DOMAIN_NAME|Fully Qualified Domain Name|
|VHOST_NAME|Virtual Host name|
|SSL_CERT_PATH|Default SSL certfication file path|
|SSL_CERTKEY_PATH|Default SSL private key file path|
|SSL_STAPLING_VERIFY|OCSP Stapling mode|
|SSL_TRUSTED_CERTIFICATE_PATH|Default SSL certfication file paht|
|PUBLIC_SERVER_IP_ADDR|IP address of the public server on which the VPN client listens to Nginx|
|PUBLIC_SERVER_PORT|Port number of the public server on which the VPN client listens on Nginx|
