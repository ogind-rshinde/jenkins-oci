#!/bin/bash
#20210901   ogind-rshinde  Script is checking a 'oci-app' folder files are updated or not, if it's updated then allow to generate build by 'oci-frontend.sh' script

echo "Tag defined" 
start_tag="20210827_RC_02_HFX" #$2
end_tag="20210910_RC_01_REL" #$3

script_path=/e/fin-ci/jenkins/scripts/

echo "Directory creating a on C drive" 
mkdir -p -- /c/releases/$end_tag/oci_updates
outputPath=/c/releases/$end_tag/oci_updates
outputFile=$outputPath/oci_updated.txt
 
echo "checkout e drive"
cd /e/

echo "$(ls -lh)"

echo "Checking a diff of tags"
#git diff --name-only --diff-filter=d $start_tag $end_tag /e > $outputFile ':!/ac-test-core/*' ':!/.git*' ':!/vm/*' ':!/yarn.*' ':!*.lnk' ':!/fin-ci/*' ':!utility_billing_customer_portal/*' ':!*ech' ':!*.dat' ':!stw/stw_php/stwup/*'
git diff --name-only --diff-filter=d $start_tag $end_tag /e > $outputFile ':!/ac-test-core/*' ':!/.git*' ':!/vm/*' ':!/yarn.*' ':!*.lnk' ':!/fin-ci/*' ':!utility_billing_customer_portal/*' ':!*ech' ':!*.dat' ':!stw/stw_php/stwup/*'

echo "Processing of file for oci-app code updated or not" 
exists=$(grep -c "stw/stw_php/oci-app" $outputFile)

if [[ $exists < 1 ]]
    then
        echo "oci-app code is not modified, oci front-end build is not required!"
        exit 42
fi

echo "oci-app build process will be started..."

