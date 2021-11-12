//
//  CollectionViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 11.11.2021.
//

import UIKit


class CollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    
    //MARK:- ConfigureView
    private func configureView() {
        collectionView.backgroundColor = .gray
        setCollectionView()
        setSearchBar()
    }
    
    private func setCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")
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
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    //MARK:- UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        networkService.fetchPhotos(with: searchBar.text ?? "")
    }
}

