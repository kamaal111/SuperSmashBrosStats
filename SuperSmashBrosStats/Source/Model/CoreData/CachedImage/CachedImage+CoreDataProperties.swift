//
//  CachedImage+CoreDataProperties.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//
//

import Foundation
import CoreData


extension CachedImage {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedImage> {
        return NSFetchRequest<CachedImage>(entityName: "CachedImage")
    }

    @NSManaged public var data: Data
    @NSManaged public var key: String
    @NSManaged public var createdDate: Date
    @NSManaged public var updatedDate: Date
    @NSManaged public var id: UUID
}
