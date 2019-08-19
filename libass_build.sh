#!/bin/bash
echo "开始编译libass>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3

pushd libass-0.14.0

make clean

./autogen.sh

./configure \
  --disable-dependency-tracking \
  --with-pic \
  --host="$NDK_TOOLCHAIN_ABI" \
  --disable-asm \
  --enable-fontconfig \
  --disable-harfbuzz \
  --enable-static \
  --enable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
