# Define environment variables for Nginx
## `.env` file for Nginx
Create an environment variable configuration file `.env` in the following format.

```sh
MYDNSJP_MASTER_ID=masterid
MYDNSJP_PASSWORD=password
MYDNS_EMAIL_ADDR=user@example.com
BASE_DOMAIN_NAME=example.com
VHOST_NAME=www.example.com
SSL_CERT_PATH=/etc/nginx/default_certs/default.crt
SSL_CERTKEY_PATH=/etc/nginx/default_certs/default.key
SSL_STAPLING_VERIFY=off
SSL_TRUSTED_CERTIFICATE_PATH=/etc/nginx/default_certs/default.crt
PROXY_IP_ADDR=10.1.2.2
PROXY_PORT=8080
```

A function of each environment variable is given below.

|Env|Funciton|
|:----|:----|
|MYDNSJP_MASTER_ID|MyDNS login ID|
|MYDNSJP_PASSWORD|MyDNS login password|
|MYDNS_EMAIL_ADDR|MyDNS e-mail address|
|BASE_DOMAIN_NAME|Fully Qualified Domain Name|
|VHOST_NAME|Virtual Host name|
|SSL_CERT_PATH|Default SSL certfication file path|
|SSL_CERTKEY_PATH|Default SSL private key file path|
|SSL_STAPLING_VERIFY|OCSP Stapling mode|
|SSL_TRUSTED_CERTIFICATE_PATH|Default SSL certfication file paht|
|PROXY_IP_ADDR|proxy ip address|
|PROXY_PORT|proxy port|