//
//  UserDataModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 13/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

final class UserDataModel: ObservableObject {

    @Published var favoritedCharacters = [FavoritedCharacter]()

    private var coreDataManager = CoreDataManager.shared

    init() {
        if let favoritedCharacters = try? self.coreDataManager.fetch(FavoritedCharacter.self) {
            self.favoritedCharacters = favoritedCharacters
        }
    }

    func favoritedStarColor(characterId: Int, game: String) -> Color {
        let isFavorite = self.checkIfCharacterIsFavorite(characterId: characterId, game: game)
        if isFavorite {
            return .yellow
        }
        return .gray
    }

    func checkIfCharacterIsFavorite(characterId: Int, game: String) -> Bool {
        let favoriteCharactersContainsCharacter = self.favoritedCharacters
            .contains(where: { $0.characterId == Int64(characterId) && $0.game == game})
        return favoriteCharactersContainsCharacter
    }

    func editFavorites(characterId: Int, game: String) {
        let favoriteCharacterToDelete = self.findFavoriteCharacter(characterId: characterId, game: game)
        if let unwrappedFavoriteCharacterToDelete = favoriteCharacterToDelete {
            try? self.coreDataManager.delete(unwrappedFavoriteCharacterToDelete)
            guard let index = self.favoritedCharacters.firstIndex(of: unwrappedFavoriteCharacterToDelete) else { return }
            self.favoritedCharacters.remove(at: index)
        } else {
            let favoriteCharacter = FavoritedCharacter.insert(
                characterId: characterId,
                game: game,
                managedObjectContext: self.coreDataManager.context!)
            self.favoritedCharacters.append(favoriteCharacter)
        }
    }

    private func findFavoriteCharacter(characterId: Int, game: String) -> FavoritedCharacter? {
        var favoriteCharacterToDelete: FavoritedCharacter?
        for favoritedCharacter in self.favoritedCharacters
            where favoritedCharacter.characterId == Int64(characterId) && favoritedCharacter.game == game {
                favoriteCharacterToDelete = favoritedCharacter
                break
        }
        return favoriteCharacterToDelete
    }

}
