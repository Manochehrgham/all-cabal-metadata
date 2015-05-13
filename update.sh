#!/usr/bin/env bash

set -xue

wget https://s3.amazonaws.com/stackage-travis/all-cabal-metadata-tool/all-cabal-metadata-tool.bz2
bunzip2 all-cabal-metadata-tool.bz2
chmod +x all-cabal-metadata-tool
mv all-cabal-metadata-tool /tmp
/tmp/all-cabal-metadata-tool

if [ -n "$(git status --porcelain)" ]
then
    git add -A
    git commit -m "Update from Hackage at $(date --utc --iso=sec)" --gpg-sign=D6CF60FD
    git push git@github.com:commercialhaskell/all-cabal-metadataHEAD:master
else
    echo No changes present
fi
