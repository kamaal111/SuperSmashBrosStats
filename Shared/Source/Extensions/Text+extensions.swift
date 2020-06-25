//
//  Text+extensions.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 21/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

extension Text {
    init(localized: LocalizableKeys) {
        self.init(Localizer.getLocalizableString(of: localized))
    }
}
