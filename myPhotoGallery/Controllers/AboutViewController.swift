//
//  ViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit

protocol AboutViewDelegate: AnyObject {
    func addFavoritePhotoButtonClicked(with photo: Gallery?)
}

class AboutViewController: UIViewController {
    
    var favoriteVC = FavoriteViewController()
    
    var aboutPhoto: Gallery?
    
    var userLable = UILabel()
    var dateLable = UILabel()
    var locationLable = UILabel()
    var numOfDownloadsLable = UILabel()
    
    var userString: String?
    var dateString: String?
    var locationString: String?
    var numOfDownloadsString: String?
    
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
        configuration()
    }
    
    func configuration() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9814007878, blue: 0.8189846277, alpha: 1)
        let height = view.frame.height
        
        userString = ("Пользователь: \(aboutPhoto?.user.name ?? "Неизвестно")")
        dateString = ("Дата создания: \(aboutPhoto?.created_at ?? "Неизвестно")")
        locationString = ("Местоположение: \(aboutPhoto?.user.location ?? "Неизвестно")")
        numOfDownloadsString = ("Количество скачиваний: \(aboutPhoto?.user.total_collections ?? 0)")
        
        setLables(with: userLable, yPosition: height/2, text: userString)
        setLables(with: dateLable, yPosition: height/2 + 50, text: dateString)
        setLables(with: locationLable, yPosition: height/2 + 100, text: locationString)
        setLables(with: numOfDownloadsLable, yPosition: height/2 + 150, text: numOfDownloadsString)
        setImage()
        setButton()
        
    }
    
    func setLables(with lable: UILabel, yPosition y: CGFloat, text: String?) {
        let wight = view.frame.width
        lable.frame = CGRect(x: 30, y: y, width: wight - 60, height: 40)
        lable.text = text
        self.view.addSubview(lable)
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
        favoriteVC.addFavoritePhotoButtonClicked(with: aboutPhoto)
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

