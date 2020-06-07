//
//  HomeScreenViewModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import Combine
import SwiftUI

class HomeScreenViewModel: ObservableObject {
    @Published var characters = [Character]()

    func populateCharacters(cachedImages: [CachedImage]?) {
        Networker.getCharacters { [weak self] result in
            switch result {
            case .failure(_):
                print("Failed to get characters")
            case .success(let characters):
                let modifiedCharacters = self?.modifyCharacters(characters: characters, cachedImages: cachedImages) ?? []
                DispatchQueue.main.async {
                    self?.characters = modifiedCharacters
                }
            }
        }
    }

    private func modifyCharacters(characters: [CodableCharacter], cachedImages: [CachedImage]?) -> [Character] {
        var modifiedCharacters = [Character]()
        if let unwrappedCachedImages = cachedImages {
            modifiedCharacters = characters.map { character in
                let thumbnailCache = self.extractThumbnailImageFromCache(
                    character: character,
                    cachedImages: unwrappedCachedImages)
                return Character(id: character.id, character: character, cachedThumbnailUrl: thumbnailCache)
            }
        } else {
            modifiedCharacters = characters.map { Character(id: $0.id, character: $0) }
        }
        return modifiedCharacters
    }

    private func extractThumbnailImageFromCache(character: CodableCharacter, cachedImages: [CachedImage]) -> Data? {
        guard cachedImages.contains(where: { $0.key == character.thumbnailUrl }) else { return nil }
        for cachedImage in cachedImages where cachedImage.key == character.thumbnailUrl {
            return cachedImage.data
        }
        return nil
    }
}
