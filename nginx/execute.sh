#!/bin/bash

readonly certs_path=/etc/letsencrypt
readonly domains="-d ${BASE_DOMAIN_NAME} -d *.${BASE_DOMAIN_NAME}"

# ==============
# initialization
# ==============
# cron script
{
    echo '#!/bin/bash'
    echo ""
    echo 'echo "[start]" $(date "+%Y/%m/%d-%H:%M:%S")'
    echo "certbot renew --post-hook '/usr/sbin/nginx -s reload'"
    echo 'echo "[ end ]" $(date "+%Y/%m/%d-%H:%M:%S")'
} > /data/cron_script.sh
chmod 755 /data/cron_script.sh

# setup cron
{
    echo '23 1 * * *' "/data/cron_script.sh"
} > /var/spool/cron/crontabs/root

# check direct_edit/txtedit.php
readonly mydns_path=/data/direct_edit
if [ -e ${mydns_path} ]; then
    # if txtedit.conf does not exist
    if [ ! -e ${mydns_path}/txtedit.conf ]; then
        # if sample.txtedit.conf exists
        if [ -e ${mydns_path}/sample.txtedit.conf ]; then
            # copy to txtedit.conf
            cp -f ${mydns_path}/sample.txtedit.conf ${mydns_path}/txtedit.conf
        else
            # invalid pattern
            echo Error: txtedit.conf does not exist and cannot be created.
            exit 1
        fi
    fi
fi

# get cert
if [ ! -e ${certs_path}/live/${BASE_DOMAIN_NAME} ]; then
    cp -f /etc/nginx/default_certs/dhparam.pem ${certs_path}
    echo =============================================
    echo execute command
    echo certbot certonly -c /data/cli.ini ${domains}
    echo =============================================
    echo
    certbot certonly -c /data/cli.ini ${domains}
fi

# create config file
readonly env_vars=$({
    echo '$$VHOST_NAME'
    echo '$$SSL_CERT_PATH'
    echo '$$SSL_CERTKEY_PATH'
    echo '$$SSL_STAPLING_VERIFY'
    echo '$$SSL_TRUSTED_CERTIFICATE_PATH'
    echo '$$PUBLIC_SERVER_IP_ADDR'
    echo '$$PUBLIC_SERVER_PORT'
} | tr '\n' ' ')
cat /etc/nginx/template/default.template | envsubst "${env_vars}" > /etc/nginx/conf.d/default.conf

is_running=1

handler(){
    echo sigterm accepted

    is_running=0
}
trap handler 1 2 3 15

# start programs
echo "[nginx and cron]" $(date "+%Y/%m/%d-%H:%M:%S") start
/usr/sbin/nginx
/usr/sbin/crond

while [ ${is_running} -eq 1 ]; do
    sleep 1
done
