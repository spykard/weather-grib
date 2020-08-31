#!/usr/bin/env bash

# Creates installer from an already built application and data
# Assumes this script being copied to the root of 'qtbuild' in the following folder structure:
# UPDATE VERSION and RELEASE DATES in all component xml files

# -- qtbuild 
#		-- linux_online_installer					(structure as copied from the repository clone)
#				-- config
#				-- packages
#						-- org.opengribs.oceanroute.core.linux	
#								-- data 		(copy the OceanRoute.AppImage, LICENSE & README.md to here)
#										--icons
#												OceanRoute.ico
#												OceanRoute.png				
#								-- meta
#						-- org.opengribs.oceanroute.data	
#								-- data			(latest OceanRoute 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#						-- org.opengribs.oceanroute.maps
#								-- data			(hires map 'data' structure should be copied here under 'data' 2x data !)
#								-- meta
#				-- repository
#						-- linux				(should be empty)
#
#
# After running the script the compiled installers should be in the linux_online_installer folder and the repository should be ready for upload
#

XVER="1.2.6"

## go to the installer build folder
cd linux_online_installer

## check that the AppImage exits and executable bit is set
if [ ! -f "packages/org.opengribs.oceanroute.core.linux/data/OceanRoute.AppImage" ]; then
	echo "OceanRoute.AppImage is not in the core data folder, can't continue"
	exit 1
fi

chmod a+x packages/org.opengribs.oceanroute.core.linux/data/OceanRoute.AppImage

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

$REPOGEN --update-new-components -v -p packages repository/linux

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
$BINARYCREATOR --online-only -v -c config/config.xml -p packages OceanRoute_Linux_Online_Installer_v$XVER
$BINARYCREATOR -v -c config/config.xml -p packages -e org.opengribs.oceanroute.maps OceanRoute_Linux_Offline_Installer_v$XVER
$BINARYCREATOR -v --offline-only -c config/config.xml -p packages  OceanRoute_Linux_Testing_Installer_v$XVER
tar -cvzf OceanRoute_Linux_Online_Installer_v$XVER.tgz OceanRoute_Linux_Online_Installer_v$XVER
tar -cvzf OceanRoute_Linux_Offline_Installer_v$XVER.tgz OceanRoute_Linux_Offline_Installer_v$XVER
tar -cvzf OceanRoute_Linux_Testing_Installer_v$XVER.tgz OceanRoute_Linux_Testing_Installer_v$XVER

echo "++++ All Done ++++"
