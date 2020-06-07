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
    @Published var characters = [CharacterWithImage]()

    func populateCharacters(cachedImages: [CachedImage]?) {
        Networker.getCharacters { result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let characters):
                var modifiedCharacters = [CharacterWithImage]()
                if let unwrappedCachedImages = cachedImages {
                    modifiedCharacters = characters.map { character in
                        let characterToReturn = character
                        var thumbnailCache: Data?
                        if unwrappedCachedImages.contains(where: { $0.key == characterToReturn.thumbnailUrl }) {
                            for cachedImage in unwrappedCachedImages where cachedImage.key == characterToReturn.thumbnailUrl {
                                thumbnailCache = cachedImage.data
                            }
                        }
                        return CharacterWithImage(id: characterToReturn.id, character: characterToReturn, cachedThumbnailUrl: thumbnailCache)
                    }
                } else {
                    modifiedCharacters = characters.map { character in
                        return CharacterWithImage(id: character.id, character: character)
                    }
                }
                DispatchQueue.main.async {
                    self.characters = modifiedCharacters
                }
            }
        }
    }
}

struct CharacterWithImage: Hashable, Identifiable {
    let id: String
    let character: Character
    var cachedThumbnailUrl: Data? = nil

    init(id: String, character: Character, cachedThumbnailUrl: Data? = nil) {
        self.id = id
        self.character = character
        self.cachedThumbnailUrl = cachedThumbnailUrl
    }
}
