#!/bin/sh

#  before_build.sh
#  SuperSmashBrosStats
#
#  Created by Kamaal Farah on 17/06/2020.
#  Copyright © 2020 Kamaal. All rights reserved.

if which swiftlint >/dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
