#!/bin/bash
echo "开始编译ffmpeg>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
. settings.sh $1 $2 $3

pushd ffmpeg
export PKG_CONFIG_PATH=$PKG_CONFIG_LIBDIR

make clean

./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--disable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-nonfree \
--enable-pic \
--enable-encoder=libfdk_aac \
--enable-decoder=libfdk_aac \
--enable-libx264 \
--enable-libass \
--enable-libfreetype \
--enable-libfribidi \
--enable-libmp3lame \
--enable-fontconfig \
--enable-pthreads \
--disable-debug \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--enable-gpl \
--disable-doc \
--enable-shared \
--enable-static \
--enable-small \
--enable-muxer=adts \
--enable-ffmpeg \
--enable-cross-compile \
--disable-htmlpages \
--disable-manpages \
--disable-podpages \
--disable-txtpages \
--disable-indev=v4l2 \
--pkg-config=$FFMPEG_PKG_CONFIG \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lpng -lexpat -lm" \
--extra-cxxflags="$CXX_FLAGS" || exit 1
make -j${NUMBER_OF_CORES} && make install || exit 1

popd
