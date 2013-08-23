#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh
. ~/gcc_4.4.3.sh

mv .git .git-halt

export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_p311x_v2.3_oc_defconfig
fi

. $KERNELDIR/.config

cd $KERNELDIR/
make -j3 || exit 1

mkdir -p $KERNELDIR/BUILT-P311x/lib/modules

rm $KERNELDIR/BUILT-P311x/lib/modules/*
rm $KERNELDIR/BUILT-P311x/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT-P311x/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT-P311x/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT-P311x/

mv .git-halt .git
