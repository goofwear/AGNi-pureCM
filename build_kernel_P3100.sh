#!/bin/sh
export KERNELDIR=`readlink -f .`
. ~/AGNi_stamp_CM.sh
. ~/gcc_4.7.2_armv7l.sh

mv .git .git-halt

export ARCH=arm

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_p3100_v2.3_oc_defconfig
fi

. $KERNELDIR/.config

echo "BEGINING KERNEL COMPILATION .........."
cd $KERNELDIR/
make -j2 || exit 1

mkdir -p $KERNELDIR/BUILT-P3100/lib/modules
rm $KERNELDIR/BUILT-P3100/lib/modules/*
rm $KERNELDIR/BUILT-P3100/zImage

echo "BEGINING SGX540 PVR KM COMPILATION ..........."
cd $KERNELDIR/pvr_source/eurasiacon/build/linux2/omap4430_android
make clean
make TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.2.2 || exit
make clean
mv $KERNELDIR/pvr_source/eurasiacon/binary2_540_120_omap4430_android_release/target/*.ko $KERNELDIR/BUILT-P3100/lib/modules/
rm -rf $KERNELDIR/pvr_source/eurasiacon/binary2_540_120_omap4430_android_release

echo "PREPARING BUILT-P3100 ..........."
cd $KERNELDIR
find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT-P3100/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT-P3100/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT-P3100/

mv .git-halt .git

echo "COMPILATION TASKS FOR CM P3100 COMPLETE !!!!!!!!"