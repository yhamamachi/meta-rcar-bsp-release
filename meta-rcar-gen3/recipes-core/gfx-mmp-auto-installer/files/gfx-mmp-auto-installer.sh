#!/bin/sh

timeout="10"
i="0"
GFX_MMP_FILEPATH="/data/gfx_mmp.tar.bz2"

while [ $i -lt $timeout ]
do
    if [ -e ${GFX_MMP_FILEPATH} ]
    then
        echo "GFX/MMP package is found."

        if [ -e /etc/powervr.ini ]
        then
            echo "GFX/MMP has been already installed."
            break
        fi

        tar xof ${GFX_MMP_FILEPATH} -C /
        echo "GFX/MMP package has been installed."A
        echo "The board will reboot automatically."
        sleep 5s
        reboot
        break
    else
        i=$((i + 1))
        sleep 1s
    fi
done

