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

struct Gallery: Codable, Equatable {
    static func == (lhs: Gallery, rhs: Gallery) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let created_at: String
    let urls: URLS
    let user: User
}

struct URLS: Codable {
    let small: String
}

struct User: Codable {
    let name: String
    let location: String?
    let total_collections: Int?
}

