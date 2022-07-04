DESCRIPTION = "Script to install Kernel module automatically on system bootup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INITSCRIPT_NAME = "kernel-module-auto-installer.sh"
SYSTEMD_SERVICE_FILENAME = "kernel-module-auto-installer.service"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE_${PN} = "${SYSTEMD_SERVICE_FILENAME}"


SRC_URI = " \
    file://${INITSCRIPT_NAME} \
    file://${SYSTEMD_SERVICE_FILENAME} \
"

S = "${WORKDIR}"

do_compile[noexec] = "1"

do_install () {
    install -d ${D}/${USRBINPATH}
    install -m 0755 ${WORKDIR}/${INITSCRIPT_NAME} ${D}/${USRBINPATH}
    install -d ${D}/${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/${SYSTEMD_SERVICE_FILENAME} ${D}/${systemd_unitdir}/system
}

