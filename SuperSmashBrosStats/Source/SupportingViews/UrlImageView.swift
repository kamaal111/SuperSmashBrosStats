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
    var cachedThumbnailImage: Data?

    init(imageUrl: String?, cachedThumbnailImage: Data?, colorTheme: Color) {
        self.urlImageModal = UrlImageModel(urlString: imageUrl, cachedThumbnailImage: cachedThumbnailImage)
        self.colorTheme = colorTheme
    }

    var body: some View {
        ZStack {
            Circle()
                .frame(width: Self.thumbnailSize.width, height: Self.thumbnailSize.height)
                .foregroundColor(colorTheme)
            Image(uiImage: urlImageModal.image ?? Self.defaultImage!)
                .resizable()
                .scaledToFit()
                .frame(width: Self.thumbnailSize.width, height: Self.thumbnailSize.height)
                .clipShape(Circle())
        }
    }

    static var defaultImage = UIImage(systemName: "photo")
    static var thumbnailSize = CGSize(width: 48, height: 48)
}
