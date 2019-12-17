* FFmpeg for Android compiled with x264, libass, fontconfig, freetype and fribidi
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
* Set environment variable
  1. export ANDROID_NDK={Android NDK Base Path}
* Run following commands to compile ffmpeg
  1. sudo apt-get --quiet --yes install build-essential git autoconf libtool pkg-config gperf gettext yasm python-lxml
  2. ./init_update_libs.sh
  3. ./android_build.sh
* To update submodules and libraries you can use ./init_update_libs.sh command
* Find the executable binary in build directory.
* If you want to use FONTCONFIG then you need to specify your custom fontconfig config file (e.g - "FONTCONFIG_FILE=/sdcard/fonts.conf ./ffmpeg --version", where /sdcard/fonts.conf is location of your FONTCONFIG configuration file).
* You can also download [prebuilt-binaries](https://github.com/hiteshsondhi88/ffmpeg-android/releases/latest) (Releases &gt; Downloads &gt; prebuilt-binaries[zip|tar.gz]).

License
----
check files LICENSE.GPLv3 and LICENSE

