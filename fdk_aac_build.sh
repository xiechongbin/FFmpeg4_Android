
#!/bin/bash
echo "开始编译fdk_aac>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3

pushd fdk-aac-2.0.0

make clean

./configure \
  --with-pic \
  --host="$NDK_TOOLCHAIN_ABI" \
  --enable-static \
  --enable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

