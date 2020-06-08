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

    var cachedDataImage: Data?

    init(imageUrl: String?, cachedDataImage: Data?) {
        self.urlImageModal = UrlImageModel(urlString: imageUrl, cachedThumbnailImage: cachedDataImage)
    }

    var body: Image {
        Image(uiImage: urlImageModal.image ?? Self.defaultImage!)
            .resizable()
    }

    static var defaultImage = UIImage(systemName: "photo")
}
