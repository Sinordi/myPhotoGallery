//
//  FavoriteViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 14.11.2021.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    private var favoritePhoto = [Gallery]()
    var someArray = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
    }
    override func viewDidAppear(_ animated: Bool) {
        print(favoritePhoto.count)
        print(someArray.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhoto.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseId, for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        cell.configure(with: favoritePhoto[indexPath.row])
        return cell
    }
    
    func addFavoritePhotoButtonClicked(with photo: Gallery?) {
        someArray.append(4)
        print(someArray.count)
        guard let photo = photo else {return}
        favoritePhoto.append(photo)
        print("Cейчас в массиве \(favoritePhoto.count) элементов и \(someArray.count)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

