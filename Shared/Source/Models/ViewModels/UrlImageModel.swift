//
//  UrlImageModel.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit
import Combine

final class UrlImageModel: ObservableObject {
    @Published var image: UIImage?

    private var urlString: String?
    private var cachedDataImage: Data?

    private var imageCache = ImageCache.getImageCache()
    private let coreDataManager = CoreDataManager.shared

    private var kowalskiAnalysis: Bool
    private let networker: Networkable?

    init(
        urlString: String?,
        cachedDataImage: Data?,
        networker: Networkable = Networker(),
        kowalskiAnalysis: Bool = false) {
        self.kowalskiAnalysis = kowalskiAnalysis
        self.networker = networker
        self.urlString = urlString
        self.cachedDataImage = cachedDataImage
        let loaded = loadImageFromCache()
        self.analyse("\(self.urlString ?? "") loaded from NSCache")
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
        if let cachedThumbnailImage = self.cachedDataImage {
            guard let image = UIImage(data: cachedThumbnailImage) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            self.networker?.loadImage(from: urlString) { [weak self] result in
                switch result {
                case .failure(let failure):
                    self?.analyse("*** Failed to load image of \(urlString) -> \(failure)")
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

    private func analyse(_ message: String) {
        if self.kowalskiAnalysis {
            print(message)
        }
    }
}
