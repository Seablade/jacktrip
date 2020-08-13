#!/bin/sh

# The qt bin folder needs to be in your PATH for this script to work.
rm -rf QJackTrip.app
cp -a QJackTrip.app_template QJackTrip.app
cp -f ../build/qjacktrip QJackTrip.app/Contents/MacOS/

# If you want to create a signed package, modify the codesign parameter below as appropriate.
macdeployqt QJackTrip.app -codesign="Developer ID Application: Aaron Wyatt"
# Needed for notarization.
mkdir -p QJackTrip.app/Contents/Frameworks/Jackmp.framework/Versions/A/Resources
cd QJackTrip.app/Contents/Frameworks/Jackmp.framework/Versions
cp /Library/Frameworks/Jackmp.framework/Versions/A/Jackmp A/
cp /Library/Frameworks/Jackmp.framework/Versions/A/Resources/Info.plist A/Resources/
ln -s A Current
cd ..
ln -s Versions/Current/Jackmp Jackmp
ln -s Versions/Current/Resources Resources
cd ../../../..
codesign -s "Developer ID Application: Aaron Wyatt" QJackTrip.app/Contents/Frameworks/Jackmp.framework/Versions/A/Jackmp 
codesign -s "Developer ID Application: Aaron Wyatt" QJackTrip.app/Contents/Frameworks/Jackmp.framework/Versions/A 
codesign -f -s "Developer ID Application: Aaron Wyatt" --entitlements entitlements.plist --options "runtime" QJackTrip.app