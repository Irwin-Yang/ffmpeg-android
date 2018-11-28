#!/bin/bash

. abi_settings.sh $1 $2 $3

pushd ffmpeg

case $1 in
  armeabi-v7a | armeabi-v7a-neon)
    CPU='cortex-a8'
  ;;
  x86)
    CPU='i686'
  ;;
esac

make clean
#Removed:
#--enable-fontconfig \
#--enable-libfreetype \
#--enable-pthreads \
#--enable-libfribidi \


./configure \
--target-os="$TARGET_OS" \
--cross-prefix="$CROSS_PREFIX" \
--arch="$NDK_ABI" \
--cpu="$CPU" \
--enable-runtime-cpudetect \
--sysroot="$NDK_SYSROOT" \
--enable-pic \
--enable-libx264 \
--enable-libass \
--enable-libmp3lame \
--disable-debug \
--enable-version3 \
--enable-hardcoded-tables \
--disable-ffplay \
--disable-ffprobe \
--enable-gpl \
--enable-yasm \
--disable-doc \
--disable-shared \
--enable-static \
--disable-network \
--disable-encoders \
--enable-jni \
--enable-mediacodec \
--enable-decoder=h264_mediacodec \
--enable-hwaccel=h264_mediacodec \
--enable-decoder=hevc_mediacodec \
--enable-decoder=mpeg4_mediacodec \
--enable-decoder=vp8_mediacodec \
--enable-decoder=vp9_mediacodec \
--enable-encoder=libx264 \
--enable-encoder=aac \
--enable-encoder=mpeg4 \
--enable-encoder=libfdk_aac \
--enable-encoder=bmp \
--enable-encoder=png \
--enable-encoder=mjpeg \
--enable-encoder=ljpeg \
--enable-encoder=jpegls \
--enable-encoder=jpeg2000 \
--enable-encoder=gif \
--disable-decoders \
--enable-decoder=aac \
--enable-decoder=h264 \
--enable-decoder=mp3 \
--enable-decoder=mpeg4 \
--enable-decoder=bmp \
--enable-decoder=png \
--enable-decoder=gif \
--enable-decoder=jpeg2000 \
--enable-decoder=jpegls \
--enable-decoder=mjpeg \
--enable-decoder=mjpegb \
--enable-decoder=yuv4 \
--pkg-config="${2}/ffmpeg-pkg-config" \
--prefix="${2}/build/${1}" \
--extra-cflags="-I${TOOLCHAIN_PREFIX}/include $CFLAGS" \
--extra-ldflags="-L${TOOLCHAIN_PREFIX}/lib $LDFLAGS" \
--extra-libs="-lpng -lexpat -lm" \
--extra-cxxflags="$CXX_FLAGS" || exit 1

make -j${NUMBER_OF_CORES} && make install || exit 1

popd
