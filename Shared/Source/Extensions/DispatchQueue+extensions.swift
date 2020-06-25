//
//  DispatchQueue+extensions.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 09/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static let apiCallThread = DispatchQueue(label: "api-call-thread", qos: .utility, attributes: .concurrent)
    static let loadImageThread = DispatchQueue(label: "load-image-thread", qos: .utility, attributes: .concurrent)
    static let setupTopList = DispatchQueue(label: "setup-top-list", qos: .utility, attributes: .concurrent)
}
