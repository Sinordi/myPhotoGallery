//
//  PhotoCell.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 12.11.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let reuseId = "PhotoCell"
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
    }
    
    //Для того, чтобы обнулять картинку при переиспользовании
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.photoImageView.image = image
            }
        }
        task.resume()
    }

}
