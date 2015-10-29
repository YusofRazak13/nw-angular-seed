#!/bin/bash

VER="v0.12.2"
DOWNLOADLINK="http://dl.nwjs.io/${VER}/nwjs-${VER}-osx-x64.zip"
DOWNLOADFILE="/tmp/nwjs-${VER}-osx-x64.zip"
LIBHOST="http://192.168.0.197/nwng-libs/"

if ! [ -f $DOWNLOADFILE ]; then
  wget "$DOWNLOADLINK" -O "$DOWNLOADFILE"
fi
unzip -o "$DOWNLOADFILE"

if [ -d "nwjs.app" ]; then
  rm -Rf nwjs.app
fi

mv "nwjs-${VER}-osx-x64/nwjs.app" ./
rm -Rf "nwjs-${VER}-osx-x64"

# BEGIN DEPENDENCY INJECTION
#
# ffmpegsumo
#
LIBNAME=ffmpegsumo
wget "$LIBHOST/$LIBNAME.so.zip" -O "/tmp/$LIBNAME.so.zip"
unzip -o "/tmp/$LIBNAME.so.zip" -d "nwjs.app/Contents/Frameworks/nwjs Framework.framework/Libraries/"
rm -Rf "/tmp/$LIBNAME.so.zip"
#
# WebChimera
LIBNAME=WebChimera
wget "$LIBHOST/$LIBNAME.plugin.zip" -O "/tmp/$LIBNAME.plugin.zip"
if ! [ -d "plugins" ]; then
  mkdir "plugins"
fi
unzip -o "/tmp/$LIBNAME.plugin.zip" -d "./plugins/"
rm -Rf "/tmp/$LIBNAME.plugin.zip"
#
# END DEPENDENCY INJECTION

echo "Done!"