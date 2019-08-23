#!/bin/bash

 #支持编译的平台
SUPPORTED_ARCHITECTURES=(armeabi armeabi-v7a armeabi-v7a-neon arm64-v8a x86 x86_64)
#SUPPORTED_ARCHITECTURES=(x86)

#ndk环境变量配置
ANDROID_NDK_ROOT_PATH=${ANDROID_NDK}
if [[ -z "$ANDROID_NDK_ROOT_PATH" ]]; then
  echo "You need to set ANDROID_NDK environment variable, please check instructions"
  exit
fi

#android api 版本
ANDROID_API_VERSION=23

#交叉编译工具链版本
NDK_TOOLCHAIN_ABI_VERSION=4.9

#编译时cpu核心数
NUMBER_OF_CORES=$(nproc)

HOST_UNAME=$(uname -m)
#编译目标平台
TARGET_OS=android

FFMPEG_PKG_CONFIG="$(pwd)/ffmpeg-pkg-config"

if [ "$1" =  "" ] 
then
return
fi

BASEDIR=$2

case $1 in
  armeabi)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    EXTRA_CONFIGURE='--disable-asm'
    CFLAGS='-march=armv5te -msoft-float -D__ANDROID__ -D__ARM_ARCH_5TE__ -D__ARM_ARCH_5TEJ__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
  armeabi-v7a)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    EXTRA_CONFIGURE=''
    CFLAGS='-march=armv7-a -mfloat-abi=softfp -mfpu=neon -mthumb -D__ANDROID__ -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -D__ARM_ARCH_7R__ -D__ARM_ARCH_7M__ -D__ARM_ARCH_7S__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
  armeabi-v7a-neon)
    NDK_ABI='arm'
    NDK_TOOLCHAIN_ABI='arm-linux-androideabi'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    EXTRA_CONFIGURE=''
    CFLAGS='-march=armv7-a -mfloat-abi=softfp -mfpu=neon -mthumb -D__ANDROID__ -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -D__ARM_ARCH_7R__ -D__ARM_ARCH_7M__ -D__ARM_ARCH_7S__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
  arm64-v8a)
    NDK_ABI='arm64'
    NDK_TOOLCHAIN_ABI='aarch64-linux-android'
    NDK_CROSS_PREFIX="${NDK_TOOLCHAIN_ABI}"
    EXTRA_CONFIGURE=''
    CFLAGS='-march=armv8-a -D__ANDROID__ -D__ARM_ARCH_8__ -D__ARM_ARCH_8A__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
  x86)
    NDK_ABI='x86'
    NDK_TOOLCHAIN_ABI='x86'
    NDK_CROSS_PREFIX='i686-linux-android'
    EXTRA_CONFIGURE='--disable-asm'
    CFLAGS='-march=i686 -mtune=i686 -m32 -mmmx -msse2 -msse3 -mssse3 -D__ANDROID__ -D__i686__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
  x86_64)
    NDK_ABI='x86_64'
    NDK_TOOLCHAIN_ABI='x86_64'
    NDK_CROSS_PREFIX="x86_64-linux-android"
    EXTRA_CONFIGURE='--disable-asm'
    CFLAGS='-march=core-avx-i -mtune=core-avx-i -m64 -mmmx -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mpopcnt -D__ANDROID__ -D__x86_64__'
    LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie -shared'
  ;;
esac

TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android
echo $TOOLCHAIN_PREFIX
if [ ! -d "$TOOLCHAIN_PREFIX" ]; then
  ${ANDROID_NDK_ROOT_PATH}/build/tools/make-standalone-toolchain.sh --toolchain=${NDK_TOOLCHAIN_ABI}-${NDK_TOOLCHAIN_ABI_VERSION} --platform=android-${ANDROID_API_VERSION} --install-dir=${TOOLCHAIN_PREFIX}
fi
CROSS_PREFIX=${TOOLCHAIN_PREFIX}/bin/${NDK_CROSS_PREFIX}-
NDK_SYSROOT=${TOOLCHAIN_PREFIX}/sysroot

export PKG_CONFIG_LIBDIR="${TOOLCHAIN_PREFIX}/lib/pkgconfig"

if [ $3 == 1 ]; then
  export CC="${CROSS_PREFIX}gcc --sysroot=${NDK_SYSROOT}"
  export LD="${CROSS_PREFIX}ld"
  export RANLIB="${CROSS_PREFIX}ranlib"
  export STRIP="${CROSS_PREFIX}strip"
  export READELF="${CROSS_PREFIX}readelf"
  export OBJDUMP="${CROSS_PREFIX}objdump"
  export ADDR2LINE="${CROSS_PREFIX}addr2line"
  export AR="${CROSS_PREFIX}ar"
  export AS="${CROSS_PREFIX}as"
  export CXX="${CROSS_PREFIX}g++"
  export OBJCOPY="${CROSS_PREFIX}objcopy"
  export ELFEDIT="${CROSS_PREFIX}elfedit"
  export CPP="${CROSS_PREFIX}cpp"
  export DWP="${CROSS_PREFIX}dwp"
  export GCONV="${CROSS_PREFIX}gconv"
  export GDP="${CROSS_PREFIX}gdb"
  export GPROF="${CROSS_PREFIX}gprof"
  export NM="${CROSS_PREFIX}nm"
  export SIZE="${CROSS_PREFIX}size"
  export STRINGS="${CROSS_PREFIX}strings"
fi
