#!/bin/sh

set -o pipefail && \
  xcodebuild clean build \
  -project Anchorage.xcodeproj \
  -scheme AnchorageDemo \
  -sdk iphonesimulator \
  -destination "platform=iOS Simulator,name=iPhone 6s,OS=12.1" \
  SWIFT_VERSION=4.2 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
