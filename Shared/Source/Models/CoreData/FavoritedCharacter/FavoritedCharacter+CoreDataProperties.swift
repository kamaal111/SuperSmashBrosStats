//
//  FavoritedCharacter+CoreDataProperties.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 13/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//
//

import Foundation
import CoreData

extension FavoritedCharacter {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedCharacter> {
        return NSFetchRequest<FavoritedCharacter>(entityName: "FavoritedCharacter")
    }

    @NSManaged public var createdDate: Date
    @NSManaged public var id: UUID // swiftlint:disable:this identifier_name
    @NSManaged public var game: String
    @NSManaged public var characterId: Int64

    // swiftlint:disable:next line_length
    @nonobjc public class func insert(characterId: Int, game: String, managedObjectContext: NSManagedObjectContext) -> FavoritedCharacter {
        let favoritedCharacter = FavoritedCharacter(context: managedObjectContext)
        favoritedCharacter.characterId = Int64(characterId)
        favoritedCharacter.createdDate = Date()
        favoritedCharacter.game = game
        favoritedCharacter.id = UUID()
        do {
            try managedObjectContext.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return favoritedCharacter
    }
}
