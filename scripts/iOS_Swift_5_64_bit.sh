#!/bin/sh

set -o pipefail && \
  xcodebuild clean build test \
  -project Anchorage.xcodeproj \
  -scheme Anchorage-iOS \
  -sdk iphonesimulator \
  -destination "platform=iOS Simulator,name=iPhone 6s,OS=12.2" \
  SWIFT_VERSION=5.0 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
