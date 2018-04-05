#!/bin/sh

set -o pipefail && \
  xcodebuild clean build test \
  -project Anchorage.xcodeproj \
  -scheme Anchorage-iOS \
  -sdk iphonesimulator \
  -destination "platform=iOS Simulator,name=iPhone 6s,OS=11.3" \
  SWIFT_VERSION=3.0 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | xcpretty
