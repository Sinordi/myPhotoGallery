//
//  CollectionViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit
import CLTypingLabel

class PhotoCollectionViewController: UIViewController {
    
    private var networkService: GalleryService
    private var photos = [Gallery]()
    
    init(networkService: GalleryService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = PhotoCollectionView()
    }

    private func view() -> PhotoCollectionView {
       return self.view as! PhotoCollectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    //MARK: - ConfigureView
    private func configureView() {
        networkService.delegate = self
        view().collectionView.delegate = self
        view().collectionView.dataSource = self
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

//MARK: - CollectionViewDelegate and CollectionViewDataSource
extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoURLString = photos[indexPath.row].urls.small
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(urlString: photoURLString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(dataService: DataService.shared, getImageService: GetImageService.shared)
        detailVC.detailPhoto = photos[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view().frame.width / 2), height: (view().frame.width / 2))
    }

}

//MARK: - UISearchBarDelegate
extension PhotoCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.networkService.fetchPhotos(with: searchBar.text ?? "")
        print("Запрос отправлен")
        self.view().startingLabels.isHidden = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.photos = []
        DispatchQueue.main.async {
            self.view().collectionView.reloadData()
        }
    }
}

//MARK: - GalleryServiceDelegate
extension PhotoCollectionViewController: GalleryServiceDelegate {
    func didUpdateGallery(with gallery: GalleryModel) {
        self.photos = gallery.results
        DispatchQueue.main.async {
            self.view().collectionView.reloadData()
        }
    }
}

