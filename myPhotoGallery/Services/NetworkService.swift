//
//  NetworkService.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 12.11.2021.
//

import Foundation

class NetworkService {
    
    
    func fetchPhotos(with guery: String) {
        let url = "https://api.unsplash.com/search/photos?page=1&query=\(guery)&client_id=vq44QqTLd-Y01tPUURer1a9o_QkaStYvlu4WOfUUVR4"
        performRequest(with: url)
    }
    
    private func performRequest(with url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    print("Error in task \(String(describing: error))")
                    return
                }
                if let data = data {
                    do {
                        let results = try JSONDecoder().decode(GalleryModel.self, from: data)
                        print(results)
                    } catch {
                        print("Не удалось распарсить данные")
                    }
                    
                }
            }
            task.resume()
        }
    }
}
