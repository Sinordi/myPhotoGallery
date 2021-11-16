//
//  FavoriteTableViewCell.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 14.11.2021.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    static let reuseId = "Cell"
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .gray
        contentView.addSubview(photoImageView)
        contentView.addSubview(userLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutPhoto()
        layoutLabel()
    }
    
    private func layoutPhoto() {
        photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        photoImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    private func layoutLabel() {
        userLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 25).isActive = true
    }
    
    func configureCell(with photo: Gallery?) {
        self.userLabel.text = ("UserName: \(photo?.user.name ?? "Неизвестно")")
        guard let url = URL(string: photo?.urls.small ?? "") else {return}
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
