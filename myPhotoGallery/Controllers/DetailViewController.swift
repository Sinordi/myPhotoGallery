//
//  DetailViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var dataService = DataService()
    var aboutPhoto: Gallery?
    
    init(dataService: DataService) {
        self.dataService = dataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var userLabel = UILabel()
    var dateLabel = UILabel()
    var locationLabel = UILabel()
    var numOfDownloadsLabel = UILabel()
    
    var addPhotoButton = UIButton()
    
    private let aboutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9814007878, blue: 0.8189846277, alpha: 1)
        let height = view.frame.height
        
        let userString = ("Пользователь: \(aboutPhoto?.user.name ?? "Неизвестно")")
        let dateString = ("Дата создания: \(aboutPhoto?.created_at ?? "Неизвестно")")
        let locationString = ("Местоположение: \(aboutPhoto?.user.location ?? "Неизвестно")")
        let numOfDownloadsString = ("Количество скачиваний: \(aboutPhoto?.user.total_collections ?? 0)")
        
        setLabels(with: userLabel, yPosition: height/2, text: userString)
        setLabels(with: dateLabel, yPosition: height/2 + 50, text: dateString)
        setLabels(with: locationLabel, yPosition: height/2 + 100, text: locationString)
        setLabels(with: numOfDownloadsLabel, yPosition: height/2 + 150, text: numOfDownloadsString)
        setImage()
        setButton()
        
    }
    
    func setLabels(with label: UILabel, yPosition y: CGFloat, text: String?) {
        let wight = view.frame.width
        label.frame = CGRect(x: 30, y: y, width: wight - 60, height: 40)
        label.text = text
        self.view.addSubview(label)
    }
    
    func setImage() {
        let wight = view.frame.width
        aboutImageView.frame = CGRect(x: wight/4, y: wight/4, width: wight/2, height: wight/2)
        self.view.addSubview(aboutImageView)
        self.getImage(with: aboutPhoto?.urls.small ?? "")
    }
    
    func setButton() {
        let wight = self.view.frame.width
        let height = self.view.frame.height
        
        addPhotoButton.frame = CGRect(x: wight/8, y: height - 150, width: 3 * wight / 4, height: 50)
        addPhotoButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        addPhotoButton.setTitle("Добавить в изобранное", for: .normal)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(addPhotoButton)
    }
    
    @objc func addPhotoButtonClicked(sender: UIButton!) {
        print("Кнопка нажата")
        guard let photo = aboutPhoto else {return}
        dataService.addNewPhoto(with: photo)
        let alert = UIAlertController(title: "Успешно!", message: "Ваше фото добавилось в избранное.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Ошибка 1")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("Ошибка 2")
                return
                
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.aboutImageView.image = image
                
            }
        }
        task.resume()
    }
    
    


}

