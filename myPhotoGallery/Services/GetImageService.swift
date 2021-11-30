//
//  GetImageService.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 16.11.2021.
//

import UIKit

protocol GetImageServiceDelegate: AnyObject {
    func didUpdateImage(with image: UIImage)
}

class GetImageService {
    
    static var shared: GetImageService = GetImageService()
    weak var delegate: GetImageServiceDelegate?
    
    func getImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Ошибка в создании Url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Error with \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {return}
                self?.delegate?.didUpdateImage(with: image)
            }
        }
        task.resume()
    }
}
