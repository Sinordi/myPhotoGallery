//
//  GalleryModel.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 12.11.2021.
//

import Foundation

struct GalleryModel: Codable {
    let total: Int
    let total_pages: Int
    let results: [Gallery]
}

struct Gallery: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let small: String
}

