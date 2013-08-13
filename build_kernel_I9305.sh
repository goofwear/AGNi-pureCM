#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_i9305_oc_v2.3.3_defconfig
fi

. $KERNELDIR/.config

export ARCH=arm

mv .git .git-halt

cd $KERNELDIR/
make -j4 || exit 1

mkdir -p $KERNELDIR/BUILT_I9305/lib/modules

rm $KERNELDIR/BUILT_I9305/lib/modules/*
rm $KERNELDIR/BUILT_I9305/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_I9305/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_I9305/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_I9305/

mv .git-halt .git
