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
        label.textColor = .white
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
        contentView.backgroundColor = .gray
        contentView.addSubview(photoImageView)
        contentView.addSubview(userLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.size.height, height:  contentView.bounds.size.height)
        userLabel.frame = CGRect(x: contentView.bounds.size.width / 2, y: contentView.bounds.size.height / 2, width: contentView.bounds.size.width / 2, height: 50)
        
    }
    
    func configure(with photo: Gallery?) {
        self.userLabel.text = (photo?.user.name)
        
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
