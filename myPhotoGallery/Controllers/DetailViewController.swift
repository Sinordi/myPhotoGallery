//
//  DetailViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit

//class DetailImageView: UIImageView {
//    init() {
//        super.init(frame: .zero)
//
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.clipsToBounds = true
//        self.backgroundColor = .gray
//        self.contentMode = .scaleAspectFill
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class DetailView: UIView {
    var dataService: DataService
    var detailPhoto: Gallery?
    var imageView = UIImageView()
    var button = UIButton()
    
    private let stackLabels = UIStackView()
    
    private var userLabel = UILabel()
    private var dateLabel = UILabel()
    private var locationLabel = UILabel()
    private var numOfDownloadsLabel = UILabel()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        createImageView()
//        createButtonView()
//    }
    
    init(frame: CGRect, dataService: DataService, detailPhoto: Gallery?) {
        self.detailPhoto = detailPhoto
        self.dataService = dataService
        super.init(frame: frame)
        createImageView()
        createButtonView()
        createStackLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        let viewIsABig: Bool = (self.bounds.height > 700)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: (viewIsABig ? (100) : (65))).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.7))).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.7))).isActive = true
    }
    func createButtonView() {
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        guard let photo = detailPhoto else {return}
        if dataService.arrayOfFavoritePhoto.contains(photo) {
            button.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
            button.setTitle("Удалить фото", for: .normal)
        } else {
            button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            button.setTitle("Добавить в изобранное", for: .normal)
        }
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    func createStackLabels() {
        createLabels()
        self.addSubview(stackLabels)
        stackLabels.translatesAutoresizingMaskIntoConstraints = false
        layoutStackLabels()
        setupStackLabels()
    }
    
    private func setupStackLabels() {
        stackLabels.addArrangedSubview(userLabel)
        stackLabels.addArrangedSubview(dateLabel)
        stackLabels.addArrangedSubview(locationLabel)
        stackLabels.addArrangedSubview(numOfDownloadsLabel)
    }
    private func layoutStackLabels() {
        stackLabels.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        stackLabels.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25).isActive = true
        stackLabels.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor).isActive = true
        stackLabels.spacing = 10
        stackLabels.axis = .vertical
    }
    
    
    func createLabels() {
        let userString = ("Пользователь: \(detailPhoto?.user.name ?? "Неизвестно")")
        let dateString = ("Дата создания: \(detailPhoto?.created_at ?? "Неизвестно")")
        let locationString = ("Местоположение: \(detailPhoto?.user.location ?? "Неизвестно")")
        let numOfDownloadsString = ("Количество скачиваний: \(detailPhoto?.user.total_collections ?? 0)")
        setupLabels(with: userLabel, text: userString)
        setupLabels(with: dateLabel, text: dateString)
        setupLabels(with: locationLabel, text: locationString)
        setupLabels(with: numOfDownloadsLabel, text: numOfDownloadsString)
    }
    
    
    
    
    private func setupLabels(with label: UILabel, text: String?) {
        label.text = text
        label.numberOfLines = 0
    }
}

class DetailViewController: UIViewController, GetImageServiceDelegate {
    
    private var dataService: DataService
    private let getImageService: GetImageService
    var detailPhoto: Gallery?
//    private var userLabel = UILabel()
//    private var dateLabel = UILabel()
//    private var locationLabel = UILabel()
//    private var numOfDownloadsLabel = UILabel()
    
    //    private let detailImageView: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        imageView.clipsToBounds = true
    //        imageView.backgroundColor = .gray
    //        imageView.contentMode = .scaleAspectFill
    //        return imageView
    //    }()
    

    
//    private let stackLabels: UIStackView = {
//        let stack = UIStackView()
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//    }()
    
//    private var addPhotoButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 10
//        button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//        button.setTitle("Добавить в изобранное", for: .normal)
//        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        button.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
//        return button
//    }()
    
    init(dataService: DataService, getImageService: GetImageService) {
        self.dataService = dataService
        self.getImageService = getImageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle Methods
    
    override func loadView() {
        let view = DetailView(frame: .zero, dataService: DataService.shared, detailPhoto: detailPhoto)
        view.button.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func view() -> DetailView {
       return self.view as! DetailView
    }
    
    //MARK: - Configuration View
    private func configureView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9814007878, blue: 0.8189846277, alpha: 1)
        self.getImageService.delegate = self
        //setup layouts
        setupImage()
//        setupStackLabels()
//        setupButton()
        //Setup Labels
//        let userString = ("Пользователь: \(detailPhoto?.user.name ?? "Неизвестно")")
//        let dateString = ("Дата создания: \(detailPhoto?.created_at ?? "Неизвестно")")
//        let locationString = ("Местоположение: \(detailPhoto?.user.location ?? "Неизвестно")")
//        let numOfDownloadsString = ("Количество скачиваний: \(detailPhoto?.user.total_collections ?? 0)")
//        setupLabels(with: userLabel, text: userString)
//        setupLabels(with: dateLabel, text: dateString)
//        setupLabels(with: locationLabel, text: locationString)
//        setupLabels(with: numOfDownloadsLabel, text: numOfDownloadsString)
    }
    
    private func setupImage() {
//        self.view.addSubview(detailImageView)
//        layoutImage()
        self.getImageService.getImage(with: detailPhoto?.urls.small ?? "")
    }
    
//    private func setupStackLabels() {
//        self.view.addSubview(stackLabels)
//        layoutStackLabels()
//        stackLabels.addArrangedSubview(userLabel)
//        stackLabels.addArrangedSubview(dateLabel)
//        stackLabels.addArrangedSubview(locationLabel)
//        stackLabels.addArrangedSubview(numOfDownloadsLabel)
//    }
    
//    private func setupLabels(with label: UILabel, text: String?) {
//        label.text = text
//        label.numberOfLines = 0
//    }
    
//    private func setupButton() {
//        self.view.addSubview(addPhotoButton)
//        guard let photo = detailPhoto else {return}
//        if dataService.arrayOfFavoritePhoto.contains(photo) {
//            addPhotoButton.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
//            addPhotoButton.setTitle("Удалить фото", for: .normal)
//        } else {
//            addPhotoButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            addPhotoButton.setTitle("Добавить в изобранное", for: .normal)
//        }
//        layoutButton()
//    }
    
    private func layoutImage() {
//        let viewIsABig: Bool = (view.bounds.height > 700)
//        detailImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        detailImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: (viewIsABig ? (100) : (65))).isActive = true
//        detailImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.7))).isActive = true
//        detailImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: (viewIsABig ? (0.9) : (0.7))).isActive = true
    }
    
    private func layoutStackLabels() {
//        stackLabels.centerXAnchor.constraint(equalTo: detailImageView.centerXAnchor).isActive = true
//        stackLabels.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 25).isActive = true
//        stackLabels.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
//        stackLabels.spacing = 10
//        stackLabels.axis = .vertical
    }
    
    private func layoutButton() {
//        addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        addPhotoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
//        addPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
//        addPhotoButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    //MARK: - Bisness Logic
    @objc func addPhotoButtonClicked(sender: UIButton!) {
        
        guard let photo = detailPhoto else {return}
        if dataService.arrayOfFavoritePhoto.contains(photo) {
            configureAlert(title: "Готово!", message: "Ваше фото удалено!")
            dataService.delitePhoto(with: photo)
//            addPhotoButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
//            addPhotoButton.setTitle("Добавить в изобранное", for: .normal)
            view().button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            view().button.setTitle("Добавить в изобранное", for: .normal)
            
        } else {
            dataService.addNewPhoto(with: photo)
            configureAlert(title: "Успешно!", message: "Ваше фото добавлено!")
//            addPhotoButton.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
//            addPhotoButton.setTitle("Удалить фото", for: .normal)
            view().button.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
            view().button.setTitle("Удалить фото", for: .normal)
        }
    }
    
    private func configureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func didUpdateImage(with image: UIImage) {
//        self.detailImageView.image = image
//        self.detailImageView.imageView.image = image
        view().imageView.image = image
    }
}

