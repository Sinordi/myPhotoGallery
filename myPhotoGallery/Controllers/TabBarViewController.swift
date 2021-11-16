//
//  TabBarViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let collectionVC = PhotoCollectionViewController(networkService: GalleryService())
        viewControllers = [
            setNavigationController(rootVC: collectionVC, title: "Gallery", image: UIImage(systemName: "photo.on.rectangle.angled")!),
            setNavigationController(rootVC: FavoriteViewController(dataService: DataService.shared), title: "Favorite", image: UIImage(systemName: "heart.circle")!)
        ]
    }
    
    private func setNavigationController(rootVC: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
