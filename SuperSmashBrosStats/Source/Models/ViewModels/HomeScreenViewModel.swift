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

    private var kowalskiAnalysis: Bool

    init(kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
    }

    func populateCharacters(cachedImages: [CachedImage]) {
        Networker.getCharacters { [weak self] result in
            switch result {
            case .failure(_):
                self?.analyse("Failed to get characters")
            case .success(let characters):
                let modifiedCharacters = self?.modifyCharacters(characters: characters, cachedImages: cachedImages) ?? []
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