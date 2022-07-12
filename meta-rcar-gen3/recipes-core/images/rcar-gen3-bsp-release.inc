PN_append = "-release"

IMAGE_INSTALL_append = " kernel-devicetree"

ARCH = "${@'32' if d.getVar('TARGET_ARCH') == 'arm' else '64'}"

addtask create_release_package after do_image_complete before do_build
do_create_release_package() {
    BINARY_DIR=${DEPLOY_DIR}/release/binary
    SOURCE_DIR=${DEPLOY_DIR}/release/source
    rm -rf ${BINARY_DIR} ${SOURCE_DIR}
    mkdir -p ${BINARY_DIR} ${SOURCE_DIR}

    # binary
    mkdir -p ${BINARY_DIR}/rootfs/ ${BINARY_DIR}/ipl/
    cp -rf ${DEPLOY_DIR}/licenses -t ${BINARY_DIR}
    cp -f ${DEPLOY_DIR_IMAGE}/${PN}-${MACHINE}.wic* -t ${BINARY_DIR}/rootfs
    cp -f ${DEPLOY_DIR_IMAGE}/*.srec -t ${BINARY_DIR}/ipl

    # source
    mkdir -p ${SOURCE_DIR}/yocto-layers
    cp -rf ${DEPLOY_DIR}/sources -t ${SOURCE_DIR}
    ls -d ${TOPDIR}/../poky ${TOPDIR}/../meta-* \
        | xargs -i cp -rpf {} -t ${SOURCE_DIR}/yocto-layers/
    export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
    for repo in `ls -d ${SOURCE_DIR}/yocto-layers/*`; do
        cd ${repo}; rm -f .gitignore; git clean -df; git reset --hard;
    done
    find ${SOURCE_DIR}/yocto-layers -name ".git" \
        | xargs -i rm -rf {}

    # Copy renesas-bsp-rom-writer
    if [ -e ${DEPLOY_DIR_IMAGE}/renesas-bsp-rom-writer_${ARCH}bit ]; then
        cp -rf ${DEPLOY_DIR_IMAGE}/renesas-bsp-rom-writer_${ARCH}bit -t ${BINARY_DIR}/ipl
    fi
}

