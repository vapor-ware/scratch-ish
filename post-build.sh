#!/usr/bin/env bash

# We are currently only building for linux_amd64, so we only need to
# look there. If other builds are supported, we should update to iterate
# over a path glob, e.g. dist/*/bin
base_path="dist/scratch-ish_linux_amd64"

set +x
set +e
ls -al dist

# If the binary doesn't exist, bail out, as GoReleaser should have built it
# by this point.
if [[ ! -f "${base_path}/exists" ]]; then
    echo "binary does not exist, unable to run post-build script"
    exit 1
fi

# Create a temporary directory and move the existing binary into it.
mkdir -p ${base_path}/tmp
mv ${base_path}/exists ${base_path}/tmp/exists

# Compress the binary with UPX (https://github.com/upx/upx). This cuts ~1MB from
# the curiously large binary. (1.5MB -> ~450kB)
docker run --rm -w $PWD -v $PWD:$PWD gruebel/upx:latest --best --lzma -o ${base_path}/exists ${base_path}/tmp/exists

# Remove temporary files.
rm -rf ${base_path}/tmp
