#!/bin/sh

set -o pipefail && \
  xcodebuild clean build test \
  -project Anchorage.xcodeproj \
  -scheme Anchorage-macOS \
  -sdk macosx \
  -destination "arch=x86_64" \
  SWIFT_VERSION=5.0 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
