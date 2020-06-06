//
//  UrlImageView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI
import UIKit

struct UrlImageView: View {
    @ObservedObject
    var urlImageModal: UrlImageModel

    var colorTheme: Color

    init(imageUrl: String?, colorTheme: Color) {
        self.urlImageModal = UrlImageModel(urlString: imageUrl)
        self.colorTheme = colorTheme
    }

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundColor(colorTheme)
            Image(uiImage: urlImageModal.image ?? Self.defaultImage!)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
        }
    }

    static var defaultImage = UIImage(systemName: "photo")
}

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?

    var urlString: String?
    var imageCache = ImageCache.getImageCache()

    init(urlString: String?) {
        self.urlString = urlString
        let loaded = loadImageFromCache()
        if loaded { return }
        self.loadImage()
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = self.urlString else { return false }
        guard let cacheImage = imageCache.get(forKey: urlString) else { return false }
        self.image = cacheImage
        return true
    }

    func loadImage() {
        guard let urlString = self.urlString else { return }
        Networker.loadImage(from: urlString) { result in
            switch result {
            case .failure(let failure):
                print(failure)
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                DispatchQueue.main.async {
                    self.imageCache.set(forKey: urlString, image: image)
                    self.image = image
                }
            }
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()

    private static var imageCache = ImageCache()

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }

    func set(forKey key: String, image: UIImage) {
        self.cache.setObject(image, forKey: NSString(string: key))
    }

    static func getImageCache() -> ImageCache {
        return imageCache
    }
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(imageUrl: nil, colorTheme: .red)
            .previewLayout(.sizeThatFits)
    }
}
