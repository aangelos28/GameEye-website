#!/usr/bin/env bash

# This script automatically deploys an exported copy of the website on Atria
# and sets all necessary permissions.
# Requires an active website export in the dist/ directory to work.
# This script does not automatically export the website.

REMOTE_SERVER_USERNAME="410yello"
REMOTE_SERVER_NAME="atria.cs.odu.edu"
REMOTE_SERVER_CONNECTION_STRING=${REMOTE_SERVER_USERNAME}@${REMOTE_SERVER_NAME}
REMOTE_SERVER_DEPLOYMENT_PATH="secure_html"
WEBSITE_ARCHIVE_NAME="website.tar.gz"

echo "Creating tar archive of exported website..."
cd dist/ || (echo "Please export the website first" && return)
tar -cvzf $WEBSITE_ARCHIVE_NAME *

echo -e "\nPurging old website content from $REMOTE_SERVER_NAME...\n"
ssh -T $REMOTE_SERVER_CONNECTION_STRING << EOF
  cd $REMOTE_SERVER_DEPLOYMENT_PATH || (echo "Could not find website directory on Atria" && return)
  rm -rf *
  exit
EOF

echo -e "\nUploading website archive to $REMOTE_SERVER_NAME...\n"
sftp $REMOTE_SERVER_CONNECTION_STRING << EOF
  cd $REMOTE_SERVER_DEPLOYMENT_PATH || return
  put $WEBSITE_ARCHIVE_NAME
  exit
EOF

echo -e "\nExtracting website archive and setting permissions...\n"
ssh -T $REMOTE_SERVER_CONNECTION_STRING << EOF
  cd $REMOTE_SERVER_DEPLOYMENT_PATH || return
  tar -xvf $WEBSITE_ARCHIVE_NAME
  rm $WEBSITE_ARCHIVE_NAME
  scripts/setPermissions.sh
  exit
EOF

echo -e "\nDeleting local website archive...\n"
rm $WEBSITE_ARCHIVE_NAME

echo -e "\nFinished deploying website to $REMOTE_SERVER_NAME.\n"
