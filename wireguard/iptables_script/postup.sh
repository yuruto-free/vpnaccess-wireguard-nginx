#!/bin/bash

readonly base_dir=$(cd $(dirname $0) && pwd)

ls ${base_dir}/conf.up.d/*.conf | while read config_file; do
    echo "[#] - ${config_file}"
    cat ${config_file} | grep -v "^\W*$\|\s*#.*" | while read cmd; do
        echo "[#]   ${cmd}"
        eval "${cmd}"
    done
done
