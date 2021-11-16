//
//  CollectionViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit
import CLTypingLabel


class PhotoCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    private var networkService: GalleryService
    private var photos = [Gallery]()
    
    private var startingLabels: CLTypingLabel = {
        let label = CLTypingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Введите свой запрос"
        label.charInterval = 1
        return label
    }()
    
    init(networkService: GalleryService) {
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
        setupSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.addSubview(startingLabels)
        layoutStartingLabel()
    }
    
    private func layoutStartingLabel() {
        startingLabels.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startingLabels.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
    
    private func setupSearchBar() {
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
        let photoURLString = photos[indexPath.row].urls.small
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseId, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: photoURLString)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(dataService: DataService.shared)
        detailVC.detailPhoto = photos[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK:- UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.networkService.fetchPhotos(with: searchBar.text ?? "")
        print("Запрос отправлен")
        startingLabels.isHidden = true
    }
}

extension PhotoCollectionViewController: GalleryServiceDelegate {
    
    func didUpdateGallery(with gallery: GalleryModel) {
        self.photos = gallery.results
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

