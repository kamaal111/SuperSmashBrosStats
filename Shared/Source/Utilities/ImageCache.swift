//
//  ImageCache.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 07/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import UIKit

class ImageCache {

    private var cache = NSCache<NSString, UIImage>()

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
