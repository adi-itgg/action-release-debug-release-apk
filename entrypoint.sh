#!/bin/bash

mkdir -p ./${APP_FOLDER}/build/outputs/apk/upload
cp ./${APP_FOLDER}/build/outputs/apk/debug/*-debug.apk ./${APP_FOLDER}/build/outputs/apk/upload/
cp ./${APP_FOLDER}/build/outputs/apk/release/*.apk ./${APP_FOLDER}/build/outputs/apk/upload/
zip -9 -r ./${APP_FOLDER}/build/outputs/apk/upload/mapping.zip ./${APP_FOLDER}/build/outputs/mapping/release/mapping.txt
cp ./${APP_FOLDER}/release/*.apk ./${APP_FOLDER}/build/outputs/apk/upload/

hub checkout ${REPO_BRANCH}
VERSION_NAME=$(cat ./"${APP_FOLDER}"/version.txt)
hub release create -a ./"${APP_FOLDER}"/build/outputs/apk/upload/*.apk -m "${RELEASE_TITLE} - v${VERSION_NAME}" "v${VERSION_NAME}"
