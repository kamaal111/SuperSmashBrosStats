//
//  HomeScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

final class HomeScreenViewModel: ObservableObject {

    @Published var characters = [Character]()
    @Published var showFavoritesOnly = false

    private var kowalskiAnalysis: Bool

    init(kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
    }

    func filteredCharacters(favoritedCharacters: [FavoritedCharacter]) -> [Character] {
        if !self.showFavoritesOnly { return self.characters }
        return self.characters.filter { (character: Character) in
            let characterDetails = character.details
            let characterId = characterDetails.ownerId
            let game = characterDetails.game
            return favoritedCharacters.contains(where: {
                Int($0.characterId) == characterId && $0.game == game
            })
        }
    }

    func populateCharacters(cachedImages: [CachedImage]) {
        Networker.getCharacters(game: .ultimate) { [weak self] result in
            switch result {
            case .failure(let failure):
                self?.analyse("*** Failed to get characters -> \(failure)")
            case .success(let characters):
                guard let modifiedCharacters = self?.modifyCharacters(
                    characters: characters,
                    cachedImages: cachedImages) else { return }
                DispatchQueue.main.async {
                    self?.characters = modifiedCharacters
                }
            }
        }
    }

    private func modifyCharacters(characters: [CodableCharacter], cachedImages: [CachedImage]) -> [Character] {
        let modifiedCharacters: [Character] = characters.map { character in
            let thumbnailCache = self.extractThumbnailImageFromCache(
                character: character,
                cachedImages: cachedImages)
            return Character(id: character.id, details: character, cachedThumbnailUrl: thumbnailCache)
        }
        return modifiedCharacters
    }

    private func extractThumbnailImageFromCache(character: CodableCharacter, cachedImages: [CachedImage]) -> Data? {
        guard cachedImages.contains(where: { $0.key == character.thumbnailUrl }) else { return nil }
        for cachedImage in cachedImages where cachedImage.key == character.thumbnailUrl {
            self.analyse("Found cached data of: \(cachedImage.key)")
            return cachedImage.data
        }
        return nil
    }

    private func analyse(_ message: String) {
        if self.kowalskiAnalysis {
            print(message)
        }
    }

}
