#!/bin/bash

mkdir -p ./${APP_FOLDER}/build/outputs/apk/upload

chmod +x gradlew

./gradlew assembleRelease --stacktrace

cp ./${APP_FOLDER}/release/*.apk ./${APP_FOLDER}/build/outputs/apk/upload/
cp ./${APP_FOLDER}/build/outputs/apk/debug/*-debug.apk ./${APP_FOLDER}/build/outputs/apk/upload/
cp ./${APP_FOLDER}/build/outputs/apk/release/*.apk ./${APP_FOLDER}/build/outputs/apk/upload/
zip -9 -r ./${APP_FOLDER}/build/outputs/apk/upload/mapping_apk.zip ./${APP_FOLDER}/build/outputs/mapping/release/mapping.txt

./gradlew bundleRelease --stacktrace

cp ./${APP_FOLDER}/build/outputs/bundle/debug/*.aab ./${APP_FOLDER}/build/outputs/apk/upload/
cp ./${APP_FOLDER}/build/outputs/bundle/release/*.aab ./${APP_FOLDER}/build/outputs/apk/upload/
zip -9 -r ./${APP_FOLDER}/build/outputs/apk/upload/mapping_aab.zip ./${APP_FOLDER}/build/outputs/mapping/release/mapping.txt

hub checkout ${REPO_BRANCH}
VERSION_NAME=$(cat ./"${APP_FOLDER}"/version.txt)
hub release create -a ./${APP_FOLDER}/build/outputs/apk/upload/*.apk -a ./${APP_FOLDER}/build/outputs/apk/upload/*.aab -a ./${APP_FOLDER}/build/outputs/apk/upload/*.zip -m "${RELEASE_TITLE} - v${VERSION_NAME}" "v${VERSION_NAME}"
