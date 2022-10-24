#!/bin/bash

echo "Server URL:  ${SERVER_URL}"
echo "Server Port: ${SERVER_PORT}"
echo "SSH Host:    ${SSH_HOST}"
echo "SSH Port:    ${SSH_PORT}"
echo "HTTPS Host:  ${HTTPS_HOST}"
echo "HTTPS Port:  ${HTTPS_PORT}"
echo ""

sslh -f -u root \
     --listen=${SERVER_URL}:${SERVER_PORT} \
     --ssh=${SSH_HOST}:${SSH_PORT} \
     --tls=${HTTPS_HOST}:${HTTPS_PORT}
