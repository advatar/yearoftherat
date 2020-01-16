#!/bin/bash --login

#Verify variable is provided
if [ "$1" = "" ]; then
        echo -e "Version number not provide"
        exit 1
fi

VERSION=$1

cd ~/GitHub/BLE_SDK_2020/ 
sed -i "" "s/\"\([0-9]\)\.\([0-9]\)\.\([0-9]\)/\"${VERSION}/g" GengziRat.podspec
git add .
git commit -am "${VERSION}" 
git push
git tag ${VERSION}
git push --tags
pod lib lint --allow-warnings
pod trunk push GengziRat.podspec --allow-warnings
