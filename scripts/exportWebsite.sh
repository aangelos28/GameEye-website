#!/usr/bin/env bash

# This script exports the content of the website and does minification and optimization
# of JavaScript and CSS.

echo "Creating website export directory..."
mkdir -p dist

scripts/compileStyles.sh

# Copy all HTML files
echo "Copying all HTML files..."
cp *.html dist/
cp -rf pages/ dist/

# Copy all necessary scripts
mkdir -p dist/scripts
cp scripts/setPermissions.sh dist/scripts

# Copy all assets
echo "Copying all assets..."
cp -rf assets/ dist/

cd dist || (echo "Could not find the dist directory" && return)

# Compile styles.scss
echo -e "\nDeleting SCSS files..."
cd assets/css || (echo "Could not find the dist/assets/css directory" && return)
rm -rf styles.scss styles.css.map modules/
cd ../../

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
