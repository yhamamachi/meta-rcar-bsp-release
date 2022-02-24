# meta-rcar-gen3

## Dependencies

This layer depends on:

* URI: https://github.com/yhamamachi/meta-rcar-dev-utils
  * branch: Use branch as same as this layer.

Other layers depend on each evaluation board.
* Please check dependencies by accesings the following wiki:
  * https://elinux.org/R-Car/Boards/Yocto-Gen3 (for Starter Kit)
  * https://elinux.org/R-Car/Boards/kingfisher/Yocto-Gen3 (for Kingfisher)
  * https://elinux.org/R-Car/Boards/CCPF-SK/Yocto-Gen3 (for CCPF-SK)
* Please check the page which contains Yocto BSP as same version as branch of this layer.
  * ex.) https://elinux.org/R-Car/Boards/Yocto-Gen3/v5.9.0

## Quick guide(How to use)

Follow the build instruction published on eLinux wiki up to steps before executing bitbake.
* https://elinux.org/R-Car/Boards/Yocto-Gen3
* https://elinux.org/R-Car/Boards/kingfisher/Yocto-Gen3
* https://elinux.org/R-Car/Boards/CCPF-SK/Yocto-Gen3

After that, executing following commands to build the BSP:
```
BUILD_DIR=`pwd`
cd ${WORK}
git clone https://github.com/yhamamachi/meta-rcar-bsp-release -b <branch_name>
cp meta-rcar-bsp-release/meta-rcar-gen3/docs/sample/site.conf.sample ${BUILD_DIR}/conf/site.conf
cd ${BUILD_DIR}
bitbake-layers add-layer ${WORK}/meta-rcar-bsp-release/meta-rcar-gen3
bitbake core-image-weston-release
```

Then. required files are stored in following path.
```
${BUILD_DIR}/tmp/deploy/release/
```

## Supported build target

- core-image-weston-release
- core-image-minimal-release

## How to select branch

"main" branch supports latest Yocto BSP in general.  
If you want to use old version of BSP(such as stable version),  
please use branch as same as Yocto BSP version.  
ex.) "v5.9.0" branch

## R-Car Generation 3 Information

Refer to the following for more information from eLinux website

https://elinux.org/R-Car

