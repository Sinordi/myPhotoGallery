//
//  DetailViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let dataService: DataService
    private let getImageService: GetImageService
    var detailPhoto: Gallery?

    init(dataService: DataService, getImageService: GetImageService) {
        self.dataService = dataService
        self.getImageService = getImageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func view() -> DetailView {
       return self.view as! DetailView
    }

    //MARK: - LifeCycle Methods
    
    override func loadView() {
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view().isFavoritePhoto()
    }
    
    private func configureView() {
        let view = DetailView(frame: .zero, dataService: DataService.shared, detailPhoto: detailPhoto)
        view.button.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
        self.view = view
    }
    
    //MARK: - Configure Image
    private func configureImage() {
        self.getImageService.delegate = self
        setupImage()
    }
    
    private func setupImage() {
        self.getImageService.getImage(with: detailPhoto?.urls.small ?? "")
    }
    
    //MARK: - Bisness Logic
    @objc func addPhotoButtonClicked(sender: UIButton!) {
        guard let photo = detailPhoto else {return}
        if dataService.arrayOfFavoritePhoto.contains(photo) {
            configureAlert(title: "Готово!", message: "Ваше фото удалено!")
            dataService.delitePhoto(with: photo)
            view().button.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            view().button.setTitle("Добавить в изобранное", for: .normal)
        } else {
            dataService.addNewPhoto(with: photo)
            configureAlert(title: "Успешно!", message: "Ваше фото добавлено!")
            view().button.backgroundColor = #colorLiteral(red: 0.6643136144, green: 0, blue: 0.08373872191, alpha: 1)
            view().button.setTitle("Удалить фото", for: .normal)
        }
    }
    
    private func configureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - GetImageServiceDelegate
extension DetailViewController :GetImageServiceDelegate {
    func didUpdateImage(with image: UIImage) {
        view().imageView.image = image
    }
}

