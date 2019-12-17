* FFmpeg for Android
--- compiled with
* x264
* libass
* fontconfig 
* freetype 
* fribidi
* fdk-aac
* lame_mp3
* libpng
* libass
* Supports Android L

Supported Architecture
----
* armv7
* armv7-neon
* x86
* arme64_v8a
* armeabi-v7a
* x86
* x86_64
* armeabi

Instructions
----
* this project is compiled on Ubuntu 16.04 systems,compiled on others systems may make mistake
* Set environment variable
  1. export ANDROID_NDK={Android NDK Base Path}
* Run following commands to compile ffmpeg
  1. sudo apt-get --quiet --yes install build-essential git autoconf libtool pkg-config gperf gettext yasm python-lxml
  2. ./android_build.sh
* Find the executable binary in build directory.
* If you want to use FONTCONFIG then you need to specify your custom fontconfig config file (e.g - "FONTCONFIG_FILE=/sdcard/fonts.conf ./ffmpeg --version", where /sdcard/fonts.conf is location of your FONTCONFIG configuration file).

License
----
check files LICENSE.GPLv3 and LICENSE

