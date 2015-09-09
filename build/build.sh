#!/bin/bash

FILENAME_BASE="splunk-add-on-google-drive"
BASEDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
VERSION=`grep version ${BASEDIR}/default/app.conf | sed 's/.*=\s*\([1-9\.]*\)/\1/' | tr -d '[:space:]'`
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

if [ "$GIT_BRANCH" = "master" ]
then
    FILENAME="${FILENAME_BASE}-${VERSION}.tar.gz"
else
    CURRENT_COMMIT=$(git rev-parse --short HEAD)
    FILENAME="${FILENAME_BASE}-${GIT_BRANCH}-${VERSION}.${CURRENT_COMMIT}.tar.gz"
fi

cd $BASEDIR
git archive --format tar.gz -o "${FILENAME}" ${GIT_BRANCH}
