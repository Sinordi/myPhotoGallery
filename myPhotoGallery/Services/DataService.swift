//
//  DataService.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 15.11.2021.
//

import Foundation

class DataService {
    static var shared: DataService = DataService()
    
    var arrayOfFavoritePhoto: [Gallery] = []
    
    func addNewPhoto(with photo: Gallery) {
        arrayOfFavoritePhoto.append(photo)
        print("Func addNewPhoto with \(photo.id)")
    }
}


