#!/bin/sh

set -o pipefail && \
  xcodebuild clean build test \
  -project Anchorage.xcodeproj \
  -scheme Anchorage-tvOS \
  -sdk appletvsimulator \
  -destination "platform=tvOS Simulator,name=Apple TV,OS=12.2" \
  SWIFT_VERSION=5.0 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
