# meta-rcar-gen3

## Quick guide(How to use)

Follow the build instruction published on eLinux wiki up to steps before executing bitbake.
```
- https://elinux.org/R-Car/Boards/Yocto-Gen3
- https://elinux.org/R-Car/Boards/kingfisher/Yocto-Gen3
- https://elinux.org/R-Car/Boards/CCPF-SK/Yocto-Gen3
```

After that, executing following commands to build the BSP:
```
BUILD_DIR=`pwd`
cd ${WORK}
git clone https://github.com/yhamamachi/meta-rcar-bsp-release -b v5.9.0
cp meta-rcar-bsp-release/meta-rcar-gen3/docs/sample/site.conf.sample ${WORK}/build/conf/site.conf
cd ${BUILD_DIR}
bitbake-layers add-layer ${WORK}/meta-rcar-bsp-release/meta-rcar-gen3
bitbake core-image-weston-release
```

Then. required files are stored in following path.
```
${WORK}/build/tmp/deploy/release/
```

## Supported build target

- core-image-weston
- core-image-minimal

## R-Car Generation 3 Information

Refer to the following for more information from eLinux website

https://elinux.org/R-Car

