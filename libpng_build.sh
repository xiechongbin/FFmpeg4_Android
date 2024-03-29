#!/bin/bash
echo "开始编译libpng>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3

pushd libpng-1.6.21

make clean

ARM_NEON="no"
case $1 in
  armeabi-v7a-neon)
    ARM_NEON="yes"
    ;;
esac

./configure \
  --with-pic \
  --with-sysroot="$NDK_SYSROOT" \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --disable-shared || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
