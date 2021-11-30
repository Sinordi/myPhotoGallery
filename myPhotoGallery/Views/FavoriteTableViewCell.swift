//
//  FavoriteTableViewCell.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 14.11.2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell, GetImageServiceDelegate {

    static let reuseId = "Cell"
    private var getImageService = GetImageService()
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    private func configureView() {
        self.getImageService.delegate = self
        contentView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        layoutPhoto()
        layoutLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutPhoto() {
        contentView.addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    private func layoutLabel() {
        let viewIsABig: Bool = (self.bounds.height > 700)
        contentView.addSubview(userLabel)
        userLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 25).isActive = true
        userLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: (viewIsABig ? (0.7) : (0.6))).isActive = true
    }
    
    func configureCell(with photo: Gallery?) {
        self.userLabel.text = ("Пользователь: \(photo?.user.name ?? "Неизвестно")")
        self.getImageService.getImage(with: photo?.urls.small ?? "")
    }
    
    func didUpdateImage(with image: UIImage) {
        self.photoImageView.image = image
    }
}
