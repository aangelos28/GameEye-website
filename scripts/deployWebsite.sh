#!/usr/bin/env bash

# This script automatically deploys an exported copy of the website on Atria
# and sets all necessary permissions.
# Requires an active website export in the dist/ directory to work.
# This script does not automatically export the website.

REMOTE_SERVER_USERNAME="410yello"
REMOTE_SERVER_NAME="atria.cs.odu.edu"
REMOTE_SERVER_CONNECTION_STRING=${REMOTE_SERVER_USERNAME}@${REMOTE_SERVER_NAME}
REMOTE_SERVER_DEPLOYMENT_PATH="secure_html"

echo "Deploying website to $REMOTE_SERVER_NAME..."
rsync -rzP dist/ --exclude={'scripts/compileStyles.sh', 'scripts/deployWebsite.sh', 'scripts/exportWebsite.sh'} \
 ${REMOTE_SERVER_CONNECTION_STRING}:${REMOTE_SERVER_DEPLOYMENT_PATH}

echo -e "\nSetting permissions...\n"
ssh -T $REMOTE_SERVER_CONNECTION_STRING << EOF
  cd $REMOTE_SERVER_DEPLOYMENT_PATH || return
  scripts/setPermissions.sh
  exit
EOF

echo -e "\nFinished deploying website to $REMOTE_SERVER_NAME.\n"
