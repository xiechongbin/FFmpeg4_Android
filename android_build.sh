#!/bin/bash
. settings.sh 
BASEDIR=$(pwd)
TOOLCHAIN_PREFIX=${BASEDIR}/toolchain-android

for i in "${SUPPORTED_ARCHITECTURES[@]}"
do
  rm -rf ${TOOLCHAIN_PREFIX}

  ./x264_build.sh $i $BASEDIR 0 || exit 1
  ./fdk_aac_build.sh $i $BASEDIR 1 || exit 1
  ./libpng_build.sh $i $BASEDIR 1 || exit 1
  ./freetype_build.sh $i $BASEDIR 1 || exit 1
  ./expat_build.sh $i $BASEDIR 1 || exit 1
  ./fribidi_build.sh $i $BASEDIR 1 || exit 1
  ./fontconfig_build.sh $i $BASEDIR 1 || exit 1
  ./libass_build.sh $i $BASEDIR 1 || exit 1
  ./lame_build.sh $i $BASEDIR 1 || exit 1
  ./ffmpeg_build.sh $i $BASEDIR 0 || exit 1
done
