require ${@"recipes-core/images/rcar-gen3-bsp-release.inc" if "rcar-gen3" in d.getVar("OVERRIDES") else ""}

WKS_FILE="rcar-dualpart-noloader.wks"

ROOTFS_POSTPROCESS_COMMAND_append = " remove_gfx_mmp_files ; "
IMAGE_INSTALL_append = " gfx-mmp-auto-installer"

remove_gfx_mmp_files() {
    # Cleanup output directory
    rm -rf ${DEPLOY_DIR_IMAGE}/gfx_mmp
    mkdir -p ${DEPLOY_DIR_IMAGE}/gfx_mmp

    # Extract gfx/mmp files
    RPMS=$(find ${DEPLOY_DIR}/rpm/${MACHINE}/ -type f \
        \( -name "*gles-user-module*" -o -name "*omx-user-module*" \) )
    if [ -n "${RPMS}" ] ;then
        echo "$RPMS" | xargs -i rpm2cpio {} | cpio -id -D ${DEPLOY_DIR_IMAGE}/gfx_mmp
    fi

    # Create gfx_mmp.tar.bz2
    tar -jcf ${DEPLOY_DIR_IMAGE}/gfx_mmp.tar.bz2 -C ${DEPLOY_DIR_IMAGE}/gfx_mmp .

    # Remove gfx/mmp related files from rootfs
    find ${DEPLOY_DIR_IMAGE}/gfx_mmp -type f \
        | awk -F/ '{print $NF}' \
        | xargs -i find '${IMAGE_ROOTFS}/' -name {} -type f \
        | xargs -i rm -f '{}'
}

do_create_release_package_append() {
    GFXMMP_DIR=${DEPLOY_DIR}/release/gfx_mmp
    rm -rf ${GFXMMP_DIR}
    mkdir -p ${GFXMMP_DIR}
    cp -f ${DEPLOY_DIR_IMAGE}/gfx_mmp.tar.bz2 -t ${GFXMMP_DIR}/
}

