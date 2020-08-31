#!/usr/bin/env bash

# Creates AppImage from an already built application
# Assumes this script being copied to the root of 'appimage_builder' that includes the following folder and file structure:


# Create a sandpit with the following directory and file structure
-----------------------------------
# usr-
#    | bin - create and copy OceanRoute executable to here
#    | lib - empty - deploytool will copy stuff needed from the release build
#    | plugins - empty - deploytool will copy stuff needed from the release build
#    | share     - create
#         | doc  - empty - deploy tool will copy stuff needed from the release build
#         | applications
#               OceanRoute.desktop (* see contents below)
#         | icons
#              | hicolor
#                   OceanRoute_32.png

# Desktop file needs to be as follows:
# [Desktop Entry] 
# Type=Application
# Name=OceanRoute
# Comment=Grib reader and weather visualization software
# Exec=OceanRoute
# Icon=OceanRoute_32
# Categories=Education;Science;Geoscience;


## run the linuxdeployqt.AppImage tool to create the executable package
if which linuxdeployqt.AppImage >/dev/null; then
  DEPLOY='linuxdeployqt.AppImage'
else
  DEPLOY="$(find ~ -name linuxdeployqt.AppImage|head -n1)"
fi
if [ -z "$DEPLOY" ]; then
  echo "Tool linuxdeployqt.AppImage not found, can't continue"
  exit 1
fi
if which qmake >/dev/null; then
  QMK='qmake'
else
  QMK="$(find /usr -name qmake|head -n1)"
fi
if [ -z "$QMK" ]; then
  echo "Tool qmake not found, can't continue"
  exit 1
fi

## create the AppImage
$DEPLOY usr/share/applications/oceanroute.desktop -qmake=$QMK -no-translations -bundle-non-qt-libs -appimage -verbose=2

## rename it
mv OceanRoute-x86_64.AppImage OceanRoute.AppImage

