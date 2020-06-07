//
//  UrlImageModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit
import Combine

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?

    private var urlString: String?
    private var cachedThumbnailImage: Data?

    private var imageCache = ImageCache.getImageCache()
    private let coreDataManager = CoreDataManager.shared

    init(urlString: String?, cachedThumbnailImage: Data?) {
        self.urlString = urlString
        self.cachedThumbnailImage = cachedThumbnailImage
        let loaded = loadImageFromCache()
        if loaded { return }
        self.loadImage()
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = self.urlString, let cacheImage = imageCache.get(forKey: urlString) else { return false }
        self.image = cacheImage
        return true
    }

    func loadImage() {
        guard let urlString = self.urlString else { return }
        if let cachedThumbnailImage = self.cachedThumbnailImage {
            guard let image = UIImage(data: cachedThumbnailImage) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            Networker.loadImage(from: urlString) { [weak self] result in
                switch result {
                case .failure(_):
                    print("Failed to load image of \(urlString)")
                case .success(let imageData):
                    self?.saveAndSetCachedImage(imageData: imageData, urlString: urlString)
                }
            }
        }
    }

    private func saveAndSetCachedImage(imageData: Data, urlString: String) {
        let cachedImage = CachedImage(context: self.coreDataManager.context!)
        cachedImage.createdDate = Date()
        cachedImage.data = imageData
        cachedImage.key = urlString
        cachedImage.id = UUID()
        cachedImage.updatedDate = Date()
        do {
            try self.coreDataManager.save()
            guard let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.imageCache.set(forKey: urlString, image: image)
                self.image = image
            }
        } catch {
            print(error)
        }
    }
}
