//
//  DetailView.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 30.11.2021.
//

import UIKit

class DetailView: UIView {
    private let detailPhoto: Gallery?
    var imageView = UIImageView()
    private let stackLabels = UIStackView()
    var button = UIButton()
    private let userLabel = UILabel()
    private let dateLabel = UILabel()
    private let locationLabel = UILabel()
    private let numOfDownloadsLabel = UILabel()
    var favoritePhoto: Bool = false {
        didSet {
            isFavoritePhoto()
        }
    }
    
    init(frame: CGRect, detailPhoto: Gallery?) {
        self.detailPhoto = detailPhoto
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration View
    private func configureView() {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.9814007878, blue: 0.8189846277, alpha: 1)
        createImageView()
        createStackLabels()
        createButtonView()
    }
    
    //MARK: - Creating Views
    //Creating ImageView
    private func createImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        layoutImageView()
    }
    private func layoutImageView() {
        let viewIsABig: Bool = (self.bounds.height > 700)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: (viewIsABig ? (100) : (65))).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.6))).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.6))).isActive = true
    }
    //Creating StackView
    func createStackLabels() {
        self.addSubview(stackLabels)
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        createLabels()
        layoutStackLabels()
        setupStackLabels()
    }
    
    private func createLabels() {
        let userString = ("Пользователь: \(detailPhoto?.user.name ?? "Неизвестно")")
        let dateString = ("Дата создания: \(detailPhoto?.created_at ?? "Неизвестно")")
        let locationString = ("Местоположение: \(detailPhoto?.user.location ?? "Неизвестно")")
        let numOfDownloadsString = ("Количество скачиваний: \(detailPhoto?.user.total_collections ?? 0)")
        setupLabel(with: userLabel, text: userString)
        setupLabel(with: dateLabel, text: dateString)
        setupLabel(with: locationLabel, text: locationString)
        setupLabel(with: numOfDownloadsLabel, text: numOfDownloadsString)
    }
    
    private func layoutStackLabels() {
        stackLabels.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        stackLabels.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
        stackLabels.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        stackLabels.spacing = 10
        stackLabels.axis = .vertical
    }
    
    private func setupStackLabels() {
        stackLabels.addArrangedSubview(userLabel)
        stackLabels.addArrangedSubview(dateLabel)
        stackLabels.addArrangedSubview(locationLabel)
        stackLabels.addArrangedSubview(numOfDownloadsLabel)
    }
    
    private func setupLabel(with label: UILabel, text: String?) {
        label.text = text
        label.numberOfLines = 0
    }
    
    //Creating ButtonView
    private func createButtonView() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layoutButton()
        isFavoritePhoto()
    }
    //Checking for photos in favorites
    func isFavoritePhoto() {
        if favoritePhoto {
            button.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
            button.setTitle("Удалить фото", for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            button.setTitle("Добавить в изобранное", for: .normal)
        }
    }
    
    private func layoutButton() {
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07).isActive = true
    }
}
