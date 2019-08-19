#!/bin/bash
echo "开始编译lamemp3>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3

pushd lame-3.100

make clean
case $1 in
  armeabi-v7a | armeabi-v7a-neon | armeabi)
    HOST=arm-linux-androideabi
  ;;
  x86)
    HOST=i686-linux-android
  ;;
  x86_64)
    HOST=x86_64-linux-android
  ;;
  arm64-v8a)
    HOST=aarch64-linux-android
  ;;
esac

./configure \
  --with-pic \
  --target=android \
  --host="$HOST" \
  --enable-static \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --enable-arm-neon="$ARM_NEON" \
  --disable-shared || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
