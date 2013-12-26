#!/bin/sh
export KERNELDIR=`readlink -f .`

cd $KERNELDIR;

echo "Building I9300 CM-type.....";
./build_kernel_I9300.sh && sleep 20 && rm .config;

echo "Building I9300 OMNI-type.....";
./build_kernel_omni_I9300.sh&& sleep 20 && rm .config;

echo "Building I9305 CM-type.....";
./build_kernel_I9305.sh && sleep 20 && rm .config;

echo "Building I9305 OMNI-type.....";
./build_kernel_omni_I9305.sh;

