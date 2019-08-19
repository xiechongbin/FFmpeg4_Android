#!/bin/bash
echo "开始编译x264>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3



pushd x264

make clean

case $1 in
  armeabi-v7a)
    HOST=arm-linux-androideabi
  ;;
   armeabi-v7a-neon)
    HOST=arm-linux-androideabi
  ;;
  armeabi)
    HOST=arm-linux-androideabi   
  ;;
  arm64-v8a)
    HOST=aarch64-linux-android   
  ;;
  x86)
    HOST=i686-linux-android   
  ;;
  x86_64)
    HOST=x86_64-linux-android
  ;;
esac

echo $CFLAGS

./configure \
  --cross-prefix="$CROSS_PREFIX" \
  --sysroot="$NDK_SYSROOT" \
  --host="$HOST" \
  --enable-pic \
  $EXTRA_CONFIGURE \
  --enable-static \
  --disable-shared \
  --prefix="${TOOLCHAIN_PREFIX}" \
  --disable-cli || exit 1

make -j${NUMBER_OF_CORES} install || exit 1

popd
