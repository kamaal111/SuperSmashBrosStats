#!/bin/sh

#  test.sh
#  SuperSmashBrosStats
#
#  Created by Kamaal Farah on 17/06/2020.
#  Copyright © 2020 Kamaal. All rights reserved.

XCODE_PROJECT="SuperSmashBrosStats.xcodeproj"
SCHEME="SuperSmashBrosStats"

DESTINATION_PLATFORM='iOS Simulator'
DESTINATION_DEVICE='iPhone 11 Pro Max'
DESTINATION_NAME="name=$DESTINATION_DEVICE"
DESTINATION="platform=$DESTINATION_PLATFORM,OS=13.5,$DESTINATION_NAME"

xcodebuild test -project $XCODE_PROJECT -scheme $SCHEME -destination "$DESTINATION" | xcpretty
