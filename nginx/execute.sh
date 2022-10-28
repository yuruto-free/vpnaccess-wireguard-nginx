#!/bin/bash

readonly certs_path=/etc/letsencrypt
readonly challenges="--preferred-challenges=dns"
readonly hooks="--manual-auth-hook /data/direct_edit/txtregist.php --manual-cleanup-hook /data/direct_edit/txtdelete.php"
readonly domains="-d ${BASE_DOMAIN_NAME} -d *.${BASE_DOMAIN_NAME}"
readonly server_name="--server https://acme-v02.api.letsencrypt.org/directory"
readonly email_addr="-m ${MYDNS_EMAIL_ADDR}"
readonly options="${challenges} ${hooks} ${domains} ${server_name} ${email_addr}"
readonly develop_mode="${DEVELOP_MODE:-FALSE}"

if [ "${develop_mode}" = "TRUE" ]; then
    # setup cron
    echo "" > /var/spool/cron/crontabs/root
else
    # ==============
    # initialization
    # ==============
    # cron script
    {
        echo '#!/bin/bash'
        echo ""
        echo 'echo "[start]" $(date "+%Y/%m/%d-%H:%M:%S")'
        echo "certbot renew --post-hook '/usr/bin/supervisorctl restart nginx'"
        echo 'echo "[ end ]" $(date "+%Y/%m/%d-%H:%M:%S")'
    } > /data/cron_script.sh
    chmod 755 /data/cron_script.sh

    # setup cron
    {
    #    cat /data/original.root
        echo '23 1 * * *' "/data/cron_script.sh"
    } > /var/spool/cron/crontabs/root

    # get cert
    if [ ! -e ${certs_path}/live/${BASE_DOMAIN_NAME} ]; then
        cp -f /etc/nginx/default_certs/dhparam.pem ${certs_path}
        echo =============================================
        echo execute command
        echo certbot certonly --manual ${options} --agree-tos --manual-public-ip-logging-ok
        echo =============================================
        echo
        echo -e "1\n" | certbot certonly --manual ${options} --agree-tos --manual-public-ip-logging-ok
    fi
fi

# create config file
cat /etc/nginx/template/default.template | \
    envsubst '$$VHOST_NAME $$SSL_CERT_PATH $$SSL_CERTKEY_PATH $$SSL_STAPLING_VERIFY $$SSL_TRUSTED_CERTIFICATE_PATH $$PROXY_IP_ADDR' > /etc/nginx/conf.d/default.conf

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
