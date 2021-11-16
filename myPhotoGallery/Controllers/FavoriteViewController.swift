//
//  FavoriteViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 14.11.2021.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    private let dataService = DataService()
    private let heigthForRow: CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.arrayOfFavoritePhoto.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heigthForRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseId, for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        cell.configureCell(with: DataService.arrayOfFavoritePhoto[indexPath.row])
        return cell
    }
}

