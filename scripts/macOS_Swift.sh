#!/bin/sh
# required: pass Swift version as first and only parameter

set -o pipefail && \
  xcodebuild clean build test \
  -project Anchorage.xcodeproj \
  -scheme Anchorage-macOS \
  -sdk macosx \
  -destination "arch=x86_64" \
  SWIFT_VERSION=$1 \
  CODE_SIGNING_REQUIRED=NO \
  CODE_SIGN_IDENTITY= \
  | bundle exec xcpretty
