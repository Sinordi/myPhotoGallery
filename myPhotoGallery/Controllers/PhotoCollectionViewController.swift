//
//  CollectionViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    var networkService: NetworkService
    var gallery: GalleryModel?
    private var photos = [Gallery]()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK:- ConfigureView
    private func configureView() {
        networkService.delegate = self
        collectionView.backgroundColor = .white
        setupCollectionView()
        setSearchBar()
        print("Сработал configureView для CollectionViewController")
    }
    
    private func setupCollectionView() {
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseId)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: (view.frame.width / 2), height: (view.frame.width / 2))
        collectionView.collectionViewLayout = layout
    }
    
        private func setSearchBar() {
            
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.delegate = self
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.searchController = searchController
        }
    
    
    //MARK:- CollectionViewDelegate and CollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var photoURLString = String()
        if let safeResult = gallery?.results[indexPath.row].urls.small {
            photoURLString = safeResult
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: photoURLString)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aboutVC = DetailViewController(dataService: DataService())
        aboutVC.aboutPhoto = photos[indexPath.row]
        self.navigationController?.pushViewController(aboutVC, animated: true)
        
    }

    
    //MARK:- UISearchBarDelegate

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.networkService.fetchPhotos(with: searchBar.text ?? "")
        print("Запрос отправлен")
    }
}

extension PhotoCollectionViewController: NetworkServiceDelegate {
    
    func didUpdateGallery(with gallery: GalleryModel) {
        self.gallery = gallery
        self.photos = gallery.results
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}
