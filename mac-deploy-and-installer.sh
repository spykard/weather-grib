#!/usr/bin/env bash

# Creates installer from an already built application and data
# Assumes this script being copied to the root of 'qtbuild' in the following folder structure:

# -- qtbuild 
#		-- deploy 								('OceanRoute.app' as copied from Qt release build folder)
#		-- mac_online_installer					(structure as copied from the repository clone)
#				-- config
#				-- packages
#						-- org.opengribs.oceanroute.core.mac	
#								-- data 		(should be empty)
#								-- meta
#						-- org.opengribs.oceanroute.data	
#								-- data			(latest OceanRoute 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#						-- org.opengribs.oceanroute.maps
#								-- data			(hires map 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#				-- repository
#						-- mac					(should be empty)
#
# Also assumes that 'OceanRoute.app' has been copied from the Qt release build folders to the 'deploy' folder
# That OceanRoute 'data' structure and hires map 'data' structure are copied to respective 'data' folders ('data' appears in two levels in each case)
#
# After running the script the installer.app should be in the mac_online_installer folder and the repository should be ready for upload
#
# UPDATE VERSION AND RELEASE DATES in xml files

XVER="v1.2.6"

## run the Qt mac deployment tool to create the executable package
cd deploy
if which macdeployqt >/dev/null; then
  DEPLOY='macdeployqt'
elif [ -f /usr/local/opt/qt5/bin/macdeployqt ]; then
  DEPLOY='/usr/local/opt/qt5/bin/macdeployqt'
else
  DEPLOY="$(find ~/Qt -name macdeployqt|head -n1)"
fi
if [ -z "$DEPLOY" ]; then
  echo "Tool macdeployqt not found, can't continue"
  exit 1
fi
$DEPLOY OceanRoute.app -verbose=2


## copy the result to the appropriate package for preparing the repository and installer
cp -R OceanRoute.app ../mac_online_installer/packages/org.opengribs.oceanroute.core.mac/data

## go to the installer build folder
cd ../mac_online_installer

## copy the .icns file to the Resource folder
cp icns/OceanRoute.icns packages/org.opengribs.oceanroute.core.mac/data/OceanRoute.app/Contents/Resources
if [ -z "packages/org.opengribs.oceanroute.core.mac/data/OceanRoute.app/Contents/Resources/OceanRoute.icns" ]; then
	echo "icns file not copied. Fix it please and rerun"
	exit 1
fi

## build the repository which should be empty (new one each time)
if which repogen >/dev/null; then
  REPOGEN='repogen'
elif [ -f /usr/local/opt/qt5/bin/repogen ]; then
  REPOGEN='/usr/local/opt/qt5/bin/repogen'
else
  REPOGEN="$(find ~/Qt -name repogen|head -n1)"
fi
if [ -z "$REPOGEN" ]; then
  echo "Tool repogen not found, can't continue"
  exit 1
fi

$REPOGEN --update-new-components -v -p packages repository/mac

## create the installer apps
## build the repository which should be empty (new one each time)
if which binarycreator >/dev/null; then
  BINARYCREATOR='binarycreator'
elif [ -f /usr/local/opt/qt5/bin/binarycreator ]; then
  BINARYCREATOR='/usr/local/opt/qt5/bin/binarycreator'
else
  BINARYCREATOR="$(find ~/Qt -name binarycreator|head -n1)"
fi
if [ -z "$BINARYCREATOR" ]; then
  echo "Tool binarycreator not found, can't continue"
  exit 1
fi
$BINARYCREATOR --online-only -v -c config/config.xml -p packages OceanRoute_Mac_Online_Installer_$XVER/OceanRoute_Mac_Online_Installer_$XVER
$BINARYCREATOR -v -c config/config.xml -p packages -e org.opengribs.oceanroute.maps OceanRoute_Mac_Offline_Installer_$XVER/OceanRoute_Mac_Offline_Installer_$XVER
$BINARYCREATOR -v --offline-only -c config/config.xml -p packages  OceanRoute_Mac_Testing_Installer_$XVER/OceanRoute_Mac_Testing_Installer_$XVER

echo "++++ All Done ++++"
