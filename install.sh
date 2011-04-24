#!/bin/bash
#
# Sets up all symlinks for configs

function normalize() {
    path="$*"
    if [[ -d $path ]]; then
        cd $path
        echo $(pwd)
    else
        dirname=$(dirname $path)
        mkdir -p ${dirname}
        cd ${dirname}
        echo $(pwd)/$(basename $path)
    fi
}

function backup() {
    path=$1
    if [[ -e ${path} && ! -L ${path} ]]; then
        backup_date=$(date +%Y%m%d)
        backup_path="${path}.${backup_date}.bak"
        mv ${path} ${backup_path}
    fi
    if [[ -L ${path} ]]; then
        rm ${path}
    fi
}

# Exit on first error we see.
set -e

# First, initialize ALL the submodules
echo "* Updating all git submodules (recursively)."
git submodule --quiet update --recursive --init

CONFIGS=$(pwd)/configs
DIRECTORIES=$(pwd)/directories

# SETUP CONFIGURATION FILES
echo "* Setting up config files."
cd ${CONFIGS}
find -type f | while read filename; do
    src_file=$(normalize $filename)
    dst_file=$(normalize ${HOME}/${filename})

    backup "${dst_file}"
    ln -fs ${src_file} ${dst_file}
done

# SETUP BASE DIRECTORIES
echo "* Setting up base directories."
cd ${DIRECTORIES}
find . -maxdepth 1 -type d -not -name . | while read directory; do
    src_dir=$(normalize ${directory})
    dst_dir=$(normalize ${HOME}/${directory})

    backup "${dst_dir}"
    ln -fs ${src_dir} ${dst_dir}
done

echo "* Done."
