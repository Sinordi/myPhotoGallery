//
//  FavoriteViewController.swift
//  myPhotoGallery
//
//  Created by Сергей Кривошапко on 14.11.2021.
//

import UIKit

class FavoriteViewController: UITableViewController {
    
    private let dataService: DataService
    
    init(dataService: DataService) {
        self.dataService = dataService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseId)
    }
    override func viewDidAppear(_ animated: Bool) {
        print(dataService.arrayOfFavoritePhoto.count)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataService.arrayOfFavoritePhoto.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseId, for: indexPath) as? FavoriteTableViewCell else {return UITableViewCell()}
        cell.configure(with: dataService.arrayOfFavoritePhoto[indexPath.row])
        return cell
    }
    
    func addFavoritePhotoButtonClicked(with photo: Gallery?) {
        guard let photo = photo else {return}
        dataService.arrayOfFavoritePhoto.append(photo)
        print("Cейчас в массиве \(dataService.arrayOfFavoritePhoto.count)")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

