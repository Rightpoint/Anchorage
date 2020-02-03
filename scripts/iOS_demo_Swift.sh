#!/bin/sh
# required: pass iOS version as first parameter
# required: pass Swift version as second parameter

set -o pipefail && \
  xcodebuild clean build \
  -project Anchorage.xcodeproj \
  -scheme AnchorageDemo \
  -sdk iphonesimulator \
  -destination "platform=iOS Simulator,name=iPhone 8,OS=$1" \
  SWIFT_VERSION=$2 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
