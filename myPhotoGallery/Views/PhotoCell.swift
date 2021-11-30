//
//  PhotoCell.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 12.11.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell, GetImageServiceDelegate {

    static let reuseId = "PhotoCell"
    private let getImageService = GetImageService()
    private let galleryService = GalleryService.shared
    
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
        getImageService.delegate = self
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
    
    func configure(urlString: String) {
        self.getImageService.getImage(with: urlString)
    }
    
    func didUpdateImage(with image: UIImage) {
        self.photoImageView.image = image
    }
}
