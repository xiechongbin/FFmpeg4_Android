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
--disable-shared \
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
make -j${NUMBER_OF_CORES} && make install
 
#以下脚本是将产生的多个ffmpeg so 打包成单一的so库 方便使用
export PLATFORM=$ANDROID_NDK_ROOT_PATH/platforms/android-$ANDROID_API_VERSION/$ARCH

if [ "$1" = "x86_64" ] 
then
echo "aaadddddddccccccc"
 ${CROSS_PREFIX}ld \
-rpath-link=$PLATFORM/usr/lib \
-L$PLATFORM/usr/lib \
-L$PLATFORM/usr/lib64 \
-L$TOOLCHAIN_PREFIX/lib \
-soname libffmpeg_core.so -shared -nostdlib -Bsymbolic --whole-archive --no-undefined -o ${2}/build/${1}/libffmpeg_core.so \
    $TOOLCHAIN_PREFIX/lib/libass.a \
    $TOOLCHAIN_PREFIX/lib/libexpat.a \
    $TOOLCHAIN_PREFIX/lib/libfdk-aac.a \
    $TOOLCHAIN_PREFIX/lib/libfontconfig.a \
    $TOOLCHAIN_PREFIX/lib/libfreetype.a \
    $TOOLCHAIN_PREFIX/lib/libfribidi.a \
    $TOOLCHAIN_PREFIX/lib/libmp3lame.a \
    $TOOLCHAIN_PREFIX/lib/libpng.a \
    $TOOLCHAIN_PREFIX/lib/libx264.a \
    ${2}/build/${1}/lib/libavcodec.a \
    ${2}/build/${1}/lib/libavfilter.a \
    ${2}/build/${1}/lib/libswresample.a \
    ${2}/build/${1}/lib/libavformat.a \
    ${2}/build/${1}/lib/libavutil.a \
    ${2}/build/${1}/lib/libswscale.a \
    ${2}/build/${1}/lib/libpostproc.a \
    ${2}/build/${1}/lib/libavdevice.a \
    -lc -lm -lz -ldl -llog --dynamic-linker=/system/bin/linker \
    $TOOLCHAIN_PREFIX/lib/gcc/$NDK_CROSS_PREFIX/4.9.x/libgcc.a
else
${CROSS_PREFIX}ld \
$LD_SINGLE_SO_CONFIGURE \
-soname libffmpeg_core.so -shared -nostdlib -Bsymbolic --whole-archive --no-undefined -o ${2}/build/${1}/libffmpeg_core.so \
    $TOOLCHAIN_PREFIX/lib/libass.a \
    $TOOLCHAIN_PREFIX/lib/libexpat.a \
    $TOOLCHAIN_PREFIX/lib/libfdk-aac.a \
    $TOOLCHAIN_PREFIX/lib/libfontconfig.a \
    $TOOLCHAIN_PREFIX/lib/libfreetype.a \
    $TOOLCHAIN_PREFIX/lib/libfribidi.a \
    $TOOLCHAIN_PREFIX/lib/libmp3lame.a \
    $TOOLCHAIN_PREFIX/lib/libpng.a \
    $TOOLCHAIN_PREFIX/lib/libx264.a \
    ${2}/build/${1}/lib/libavcodec.a \
    ${2}/build/${1}/lib/libavfilter.a \
    ${2}/build/${1}/lib/libswresample.a \
    ${2}/build/${1}/lib/libavformat.a \
    ${2}/build/${1}/lib/libavutil.a \
    ${2}/build/${1}/lib/libswscale.a \
    ${2}/build/${1}/lib/libpostproc.a \
    ${2}/build/${1}/lib/libavdevice.a \
    -lc -lm -lz -ldl -llog --dynamic-linker=/system/bin/linker \
    $TOOLCHAIN_PREFIX/lib/gcc/$NDK_CROSS_PREFIX/4.9.x/libgcc.a
fi
popd
