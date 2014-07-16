#!/bin/sh
export KERNELDIR=`readlink -f .`

cd $KERNELDIR;

echo "Building I9300 .....";
./build_kernel_I9300.sh && sleep 20 && rm .config;

echo "Building I9300 wolf .....";
./build_kernel_I9300_wolf.sh && sleep 20 && rm .config;

echo "Building I9305 .....";
./build_kernel_I9305.sh && sleep 20 && rm .config;

echo "Building I9305 wolf .....";
./build_kernel_I9305_wolf.sh;

