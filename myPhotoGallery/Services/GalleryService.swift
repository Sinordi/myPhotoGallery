//
//  GalleryService.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 12.11.2021.
//

import Foundation

protocol GalleryServiceDelegate: AnyObject {
    func didUpdateGallery(with gallery: GalleryModel)
}

class GalleryService {
    
    weak var delegate: GalleryServiceDelegate?
    
    func fetchPhotos(with guery: String) {
        print("Выполняется запрос")
        let url = "https://api.unsplash.com/search/photos?page=1&per_page=20&query=\(guery)&client_id=vq44QqTLd-Y01tPUURer1a9o_QkaStYvlu4WOfUUVR4"
        performRequest(with: url)
    }
    
    private func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { [weak self]data, response, error in
                guard let self = self else {return}
                if error != nil {
                    print("Error in task \(String(describing: error))")
                    return
                }
                if let data = data {
                    do {
                        let results = try JSONDecoder().decode(GalleryModel.self, from: data)
                        print("Данные получены и декодированы")
                        self.delegate?.didUpdateGallery(with: results)
                    } catch {
                        print("Не удалось декодировать данные")
                    }
                }
            }
            task.resume()
        }
    }
}
