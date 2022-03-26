#!/usr/bin/env bash

# Creates installer from an already built application and data
# Assumes this script being copied to the root of 'qtbuild' in the following folder structure:

# -- qtbuild 
#		-- deploy 								('Weathergrib.exe' as copied from Qt release build folder. ADD libopenjp2.dll)
#		-- win_online_installer					(structure as copied from the repository clone)
#				-- config
#				-- packages
#						-- org.opengribs.weathergrib.core.win	
#								-- data 		(should be empty except for icons folder)
#										-- icons
#												Weathergrib.ico			(check that it exists)
#								-- meta
#						-- org.opengribs.weathergrib.data	
#								-- data			(latest Weathergrib 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#						-- org.opengribs.weathergrib.maps
#								-- data			(hires map 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#				-- repository					(should be empty)
#
#
# Also assumes that 'Weathergrib.exe' has been copied from the Qt release build folders to the 'deploy' folder
# That Weathergrib 'data' structure and hires map 'data' structure are copied to respective 'data' folders ('data' appears in two levels in each case)
#
# After running the script the installers should be in the win_online_installer folder and the repository should be ready for upload
#
# UPDATE VERSION AND RELEASE DATES in xml files

XVER="v2.3.0"

## run the Qt windows deployment tool to create the executable package
cd win_online_installer/deploy
if which windeployqt >/dev/null; then
  DEPLOY='windeployqt.exe'
else
	echo "Tool windeployqt is not in the path, can't continue"
	read junk
fi

$DEPLOY --no-translations --release --no-opengl-sw Weathergrib.exe

## now copy bundle to installer package for core.win
cd ..
cd ..
cp -rf data win_online_installer/packages/org.opengribs.weathergrib.core.win/data
cp LICENSE win_online_installer/packages/org.opengribs.weathergrib.core.win/data
cp README.md win_online_installer/packages/org.opengribs.weathergrib.core.win/data

## go to the installer build folder
cd win_online_installer

## build the repository which should be empty (new one each time)
if which repogen.exe >/dev/null; then
  REPOGEN='repogen.exe'
else
  echo "Tool repogen not found in path, can't continue"
  read junk
fi

$REPOGEN --update-new-components -v -p packages repository

## create the installer apps
if which binarycreator.exe >/dev/null; then
  BINARYCREATOR='binarycreator.exe'
else
  echo "Tool binarycreator not found in path, can't continue"
  read junk
fi

$BINARYCREATOR --online-only -v -c config/config.xml -p packages Weathergrib_Win_Online_Installer_$XVER
$BINARYCREATOR -v -c config/config.xml -p packages -e org.opengribs.weathergrib.maps Weathergrib_Win_Offline_Installer_$XVER
$BINARYCREATOR -v --offline-only -c config/config.xml -p packages  Weathergrib_Win_Testing_Installer_$XVER

echo "++++ All Done ++++"
read junk
