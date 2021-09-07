#!/bin/bash

#20210901   ogind-rshinde  Script is generating a OCI frontend build basis on parameter. 

IsProductionEnv="dev"

echo "Checking your login status..." 
if ! npm whoami; then
    echo "ERROR: Your NPM userid is not set yet, Please set it"
    exit 42
fi

if [ ! -f q:/stw/stw_php/oci-app/.env-cmdrc ]; then
    echo "ERROR: env-cmdrc file not found!"
    exit 42
fi

cd /e/stw/stw_php/oci-app

echo "Installing a package..." 
npm i

echo "This will create a build for $IsProductionEnv"

buildCmd=$(npm run build:"$IsProductionEnv")
if [ ! -f $buildCmd ]; then
    echo "ERROR: Your build is failed, Please try again"
    exit 42
fi

echo "Build is created a successfully"
# echo "$(tput setaf 2)"
# deleteCmd=$(rm -rf "q:/stw/stw_php/oci-app/oci/")
# if [ ! -f $deleteCmd ]; then
#     echo "$(tput setaf 1)ERROR: Getting a error on deleting a old build files"
#     exit
# fi

# copyCmd=$(cp -r "q:/stw/stw_php/oci-app/$IsProductionEnv-oci/" "oci/")
# echo "$copyCmd"
# if [ ! -f $copyCmd ]; then
#     echo "$(tput setaf 1)ERROR: Build files replace getting a error"
#     exit
# fi

echo "******************* DONE *************************************"
 