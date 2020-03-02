#!/usr/bin/env bash

echo "Creating website export directory..."
mkdir -p websiteExport

# Copy all HTML files
echo "Copying all HTML files..."
cp *.html websiteExport/

# Copy all necessary scripts
mkdir -p websiteExport/scripts
cp scripts/setPermissions.sh websiteExport/scripts

# Copy all assets
echo "Copying all assets..."
cp -rf assets/ websiteExport/

cd websiteExport || exit

# Minify all CSS
echo -e "\nMinifying all CSS files..."
find assets/css/ -type f \
    -name "*.css" ! -name "*.min.css" ! \
    -exec sh -c 'echo "$1" && cleancss "$1" --output "$1".min && rm "$1" && mv "$1".min "$1"' _ {} \;

# Optimize all JS
echo -e "\nOptimizing all JS files..."
find assets/js/ -type f \
    -name "*.js" ! -name "*.min.js" ! \
    -exec sh -c 'echo "$1" && google-closure-compiler --js "$1" --js_output_file "$1".min && rm "$1" && mv "$1".min "$1"' _ {} \;

echo -e "\nFinished exporting website.\n"
