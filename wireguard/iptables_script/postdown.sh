#!/bin/bash

readonly base_dir=$(cd $(dirname $0) && pwd)

ls ${base_dir}/conf.down.d/*.conf | while read config_file; do
    echo "[#] - ${config_file}"
    cat ${config_file} | while read cmd; do
        echo "[#]   ${cmd}"
        eval "${cmd}"
    done
done
