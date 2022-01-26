DESCRIPTION = "Renesas BSP ROM Writer"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

S = "${WORKDIR}/git"

BRANCH = "master"
SRC_URI = "git://github.com/morimoto/renesas-bsp-rom-writer.git;branch=${BRANCH};protocol=https"
SRCREV = "2db124fe4ee834af7f413d5f35fa763f8eabba17"

PV = "git${SRCPV}"

COMPATIBLE_MACHINE = "(ulcb)"
COMPATIBLE_MACHINE_append = "|(qemuarm)"

ALLOW_EMPTY_${PN} = "1"
ALLOW_EMPTY_${PN}-dev = "1"
ALLOW_EMPTY_${PN}-staticdev = "1"

SRC_URI_append = " \
    file://0002-starterkit-linux-rom-writer-Improve-userbility.patch \
    file://0003-starterkit-linux-rom-writer-add-speed_up-support.patch \
    ${@'' if d.getVar('TARGET_ARCH') == 'arm' else \
        'file://0004-Change-to-use-AArch64-flash-writer.patch'} \
"

do_compile() {
    cd ${B}/starterkit
    oe_runmake loop_yocto
}

# do_install() nothing
do_install[noexec] = "1"

do_deploy() {
    # Create deploy folder
    install -d ${DEPLOYDIR}

    # Copy to deploy folder
    rm -rf ${DEPLOYDIR}/${PN}
    cp -rpf ${S} ${DEPLOYDIR}
    rm -rf ${DEPLOYDIR}/git/.git
    mv -f ${DEPLOYDIR}/git ${DEPLOYDIR}/${PN}
}

addtask deploy before do_build after do_compile

