require ${@"recipes-core/images/rcar-gen3-bsp-release.inc" if "rcar-gen3" in d.getVar("OVERRIDES") else ""}

WKS_FILE = "${@bb.utils.contains('DISTRO_FEATURES', 'docker', \
    'rcar-dualpart-noloader_ext4_8gb.wks', \
    'rcar-dualpart-noloader_ext4.wks', d)}"

IMAGE_INSTALL_append = " kernel-modules"

ROOTFS_POSTPROCESS_COMMAND_append = "copy_kernel_modules; "
copy_kernel_modules() {
    install -d ${IMAGE_ROOTFS}/boot/
    install -m 644 ${DEPLOY_DIR_IMAGE}/modules-${MACHINE}.tgz ${IMAGE_ROOTFS}/boot/
}

