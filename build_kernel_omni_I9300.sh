#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh
. ~/gcc_4.7.2_armv7l.sh

export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_i9300_omni_v2.5d_defconfig
fi

. $KERNELDIR/.config

mv .git .git-halt

cd $KERNELDIR/
make -j2 || exit 1

mkdir -p $KERNELDIR/BUILT_I9300_omni/lib/modules

rm $KERNELDIR/BUILT_I9300_omni/lib/modules/*
rm $KERNELDIR/BUILT_I9300_omni/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_I9300_omni/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_I9300_omni/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_I9300_omni/

mv .git-halt .git
