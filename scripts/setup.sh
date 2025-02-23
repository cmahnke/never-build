#!/usr/bin/env bash

set -e

echo "Set SKIP_IIIF to something to disable generation of IIIF derivates"
./scripts/iiif.sh

# Get models
./scripts/models.sh

# Get map
./scripts/get-map-tiles.sh

python ./scripts/extract-images.py -d

echo "Calling theme scripts"
for SCRIPT in $PWD/themes/projektemacher-base/scripts/init/*.sh ; do
    echo "Running $SCRIPT"
    bash "$SCRIPT"
done

# Favicons
#SOURCE="themes/projektemacher-base/static/images/cm.svg" OPTIONS="-transparent white static/images/favicon-128.png" ./themes/projektemacher-base/scripts/favicon.sh

yarn run svgo

./scripts/map.sh
./scripts/svgo.sh
./themes/projektemacher-base/scripts/json-lint.sh
