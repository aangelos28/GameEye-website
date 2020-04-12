#!/usr/bin/env bash

# This script compiles the styles.scss master style file, which imports
# all other scss modules.

cd assets/css || (echo "Could not find the directory assets/css" && return)

echo -e "\nCompiling styles.scss..."
sass styles.scss styles.css
echo -e "Finished compiling styles.scss...\n"
