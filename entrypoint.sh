#!/bin/bash
export KERNEL_VER="$KERNEL_VER"

# go to root dir
cd
git clone https://github.com/RobertCNelson/armv7-multiplatform
cd armv7-multiplatform/
# git checkout origin/v4.4.x -b tmp
# git checkout origin/v4.4.x-rt -b tmp etc
git checkout origin/${KERNEL_VER} -b tmp
./build_kernel.sh

cp -r /root/armv7-multiplatform/deploy /tmp/
