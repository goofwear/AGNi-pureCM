#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh
. ~/gcc_4.7.2_armv7l.sh

export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_i9300_mali-r3p1_v2.5_defconfig
fi

. $KERNELDIR/.config

mv .git .git-halt

cd $KERNELDIR/
make -j2 || exit 1

mkdir -p $KERNELDIR/BUILT_I9300_r3p1/lib/modules

rm $KERNELDIR/BUILT_I9300_r3p1/lib/modules/*
rm $KERNELDIR/BUILT_I9300_r3p1/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_I9300_r3p1/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_I9300_r3p1/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_I9300_r3p1/

mv .git-halt .git
