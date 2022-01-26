require ${@"recipes-core/images/rcar-gen3-bsp-release.inc" if "rcar-gen3" in d.getVar("OVERRIDES") else ""}

WKS_FILE="rcar-dualpart-noloader_ext4.wks"

IMAGE_INSTALL_append = " kernel-modules"

ROOTFS_POSTPROCESS_COMMAND_append = "copy_kernel_modules; "
addtask create_release_package after do_image_complete before do_build
copy_kernel_modules() {
    install -d ${IMAGE_ROOTFS}/boot/
    install -m 644 ${DEPLOY_DIR_IMAGE}/modules-${MACHINE}.tgz ${IMAGE_ROOTFS}/boot/
}

