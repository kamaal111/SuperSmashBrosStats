//
//  UrlImageView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 06/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject
    private var urlImageModel: UrlImageModel

    private var cachedDataImage: Data?
    private var placeHolderColor: Color

    init(imageUrl: String?, cachedDataImage: Data?, placeHolderColor: Color) {
        self.urlImageModel = UrlImageModel(urlString: imageUrl, cachedDataImage: cachedDataImage)
        self.placeHolderColor = placeHolderColor
    }

    var body: some View {
        self.image
            .resizable()
            .foregroundColor(self.placeHolderColor)
    }

    var image: Image {
        if let urlImage = self.urlImageModel.image {
            return Image(uiImage: urlImage)
        }
        return Self.defaultImage
    }

    static private var defaultImage = Image(systemName: "photo")
}
