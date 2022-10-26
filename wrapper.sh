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

function Usage() {
    echo $0 "build|start|down|stop|ps|logs|peers"
    echo "  Options:"
    echo "    * build"
    echo "            build docker image"
    echo "    * start"
    echo "            create containers and start them"
    echo "    * down"
    echo "            stop and destroy containers"
    echo "    * stop"
    echo "            stop containers"
    echo "    * ps"
    echo "            show process status for each containers"
    echo "    * logs"
    echo "            show log for each containers"
    echo "    * peers"
    echo "            show peer configure file path of wireguard"
}

while [ -n "$1" ]; do
    case "$1" in
        help | -h )
            Usage
            exit 0
            ;;

        build )
            # build
            docker-compose build --no-cache
            # remove old images
            docker images | grep none | awk '{print $3;}' | xargs -I{} docker rmi {}
            shift
            ;;

        start )
            # update host environment file
            update_host_envfile > ${host_envfie}
            # create all containers
            ${wrapper_cmd} up -d
            shift
            ;;

        down | stop | ps )
            docker-compose "$1"
            shift
            ;;

        logs )
            docker-compose logs -t | sort -t "|" -k 1,+2d
            shift
            ;;

        peers )
            ls wireguard/peer*/peer*.conf | grep -v "^$" | xargs -I{} echo ${PWD}/{}
            shift
            ;;

        * )
            shift
            ;;
    esac
done
