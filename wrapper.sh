#!/bin/bash

readonly base_dir=$(cd $(dirname $0) && pwd)
readonly host_envfie=${base_dir}/.env
readonly wrapper_cmd="docker-compose --env-file ${host_envfie}"

function update_host_envfile() {
    local -r _wireguard_envfile="${base_dir}/envs/wireguard/.env"
    local _wireguard_serverport=51820

    if [ -e ${_wireguard_envfile} ]; then
        # update server port of WireGuard
        _wireguard_serverport=$(grep -oP "(?<=SERVERPORT=).*" ${_wireguard_envfile})
    fi

    {
        echo HOST_WIREGUARD_SERVERPORT=${_wireguard_serverport}
    }
}


# update host environment file
update_host_envfile > ${host_envfie}

while [ -n "$1" ]; do
    case "$1" in
        build )
            # build
            ${wrapper_cmd} build --no-cache
            # remove old images
            docker images | grep none | awk '{print $3;}' | xargs -I{} docker rmi {}
            shift
            ;;

        start )
            # create all containers
            ${wrapper_cmd} up -d
            shift
            ;;

        down | stop )
            # destory or stop all containers
            ${wrapper_cmd} "$1"
            shift
            ;;

        ps )
            ${wrapper_cmd} ps
            shift
            ;;

        logs )
            ${wrapper_cmd} logs -t | sort -t "|" -k 1,+2d
            shift
            ;;

        * )
            shift
            ;;
    esac
done
