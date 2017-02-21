#!/bin/bash
GCC_BRANCH="6.3"
GCC_YM="2017.02"
GCC_MINOR="1"
UBOOT_VER="v2017.01"
GCC_ARCHIVE="gcc-linaro-${GCC_BRANCH}.${GCC_MINOR}-${GCC_YM}-x86_64_arm-linux-gnueabihf"

build_kernel() {
# go to root dir
cd
git clone https://github.com/RobertCNelson/armv7-multiplatform
cd armv7-multiplatform/
# git checkout origin/v4.4.x -b tmp
# git checkout origin/v4.4.x-rt -b tmp etc
git checkout origin/${KERNEL_VER} -b tmp
./build_kernel.sh
cp -rv /root/armv7-multiplatform/deploy /tmp/
}

build_uboot() {
# go to root dir
cd
wget -c https://releases.linaro.org/components/toolchain/binaries/$GCC_BRANCH-$GCC_YM/arm-linux-gnueabihf/$GCC_ARCHIVE.tar.xz
tar xf $GCC_ARCHIVE.tar.xz
export CC=`pwd`/$GCC_ARCHIVE/bin/arm-linux-gnueabihf-
git clone https://github.com/u-boot/u-boot
pushd u-boot
git checkout $UBOOT_VER -b tmp
wget -c https://rcn-ee.com/repos/git/u-boot-patches/$UBOOT_VER/0001-wandboard-uEnv.txt-bootz-n-fixes.patch
patch -p1 < 0001-wandboard-uEnv.txt-bootz-n-fixes.patch
make ARCH=arm CROSS_COMPILE=${CC} distclean
make ARCH=arm CROSS_COMPILE=${CC} wandboard_defconfig
# threads
make ARCH=arm CROSS_COMPILE=${CC} -j$(getconf _NPROCESSORS_ONLN)
# copy built bootloader stuff
mv -f SPL /tmp/deploy/SPL
mv -f u-boot.img /tmp/deploy
}

build_uboot
build_kernel
