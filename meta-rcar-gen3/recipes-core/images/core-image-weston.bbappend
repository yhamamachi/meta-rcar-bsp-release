require ${@"recipes-core/images/rcar-gen3-bsp-release.inc" if "rcar-gen3" in d.getVar("OVERRIDES") else ""}

WKS_FILE="rcar-dualpart-noloader.wks"

ROOTFS_POSTPROCESS_COMMAND_append = " remove_gfx_mmp_files ; "
IMAGE_INSTALL_append = " gfx-mmp-auto-installer"

remove_gfx_mmp_files() {
    find ${BASE_WORKDIR}/${MACHINE}-poky-linux/gles-user-module/1.0-r0/image -type f \
        | awk -F/ '{print $NF}' \
        | xargs -i find '${IMAGE_ROOTFS}/' -name {} -type f \
        | xargs -i rm -f '{}'

    find ${BASE_WORKDIR}/${MACHINE}-poky-linux/omx-user-module/1.0-r0/image -type f \
        | awk -F/ '{print $NF}' \
        | xargs -i find '${IMAGE_ROOTFS}/' -name {} -type f\
        | xargs -i rm -f '{}'

    rm -rf ${DEPLOY_DIR_IMAGE}/gfx_mmp
    mkdir -p ${DEPLOY_DIR_IMAGE}/gfx_mmp

    if [ -e ${BASE_WORKDIR}/${MACHINE}-poky-linux/gles-user-module/1.0-r0/image ]; then
        cp -rpf ${BASE_WORKDIR}/${MACHINE}-poky-linux/gles-user-module/1.0-r0/image/* \
            -t ${DEPLOY_DIR_IMAGE}/gfx_mmp
    fi

    if [ -e ${BASE_WORKDIR}/${MACHINE}-poky-linux/omx-user-module/1.0-r0/image ]; then
        cp -rpf ${BASE_WORKDIR}/${MACHINE}-poky-linux/omx-user-module/1.0-r0/image/* \
            -t ${DEPLOY_DIR_IMAGE}/gfx_mmp
    fi

    tar -jcf ${DEPLOY_DIR_IMAGE}/gfx_mmp.tar.bz2 -C ${DEPLOY_DIR_IMAGE}/gfx_mmp .
}

do_create_release_package_append() {
    GFXMMP_DIR=${DEPLOY_DIR}/release/gfx_mmp
    rm -rf ${GFXMMP_DIR}
    mkdir -p ${GFXMMP_DIR}
    cp -f ${DEPLOY_DIR_IMAGE}/gfx_mmp.tar.bz2 -t ${GFXMMP_DIR}/
}

