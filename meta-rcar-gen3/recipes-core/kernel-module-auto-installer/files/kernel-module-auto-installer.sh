#!/bin/sh

timeout="10"
i="0"
KERNEL_MODULE_FILEPATH="/data/modules-$(hostname).tgz)"
INSTALLED_FLAG_FILE="/etc/.kmodule_installed"

while [ $i -lt $timeout ]
do
    if [ -e ${KERNEL_MODULE_FILEPATH} ]
    then
        echo "Kernel module package is found."

        if [ -e ${INSTALLED_FLAG_FILE} ]
        then
            echo "Kernel module has been already installed."
            break
        fi

        tar xof ${KERNEL_MODULE_FILEPATH} -C /
        depmod -a
        touch ${INSTALLED_FLAG_FILE}
        echo "kernel module has been installed."
        break
    else
        i=$((i + 1))
        sleep 1s
    fi
done

