//
//  FavoriteFilmsController.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit

class FavoriteFilmsController: UITableViewController {
    //MARK: - Properties
    var favoriteFilms = [MainFilmModel]()
    //MARK: - livecycle
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteFilmCell.self, forCellReuseIdentifier: FavoriteFilmCell.indetifier)
        getFavoriteFilms()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .internetDown, object: nil)
        title = "Favorite film"
    }
    deinit {
         NotificationCenter.default.removeObserver(self)
     }
    @objc func keyboardWillShow(){
        getFavoriteFilms()
       }
    //MARK: -  helper func
    fileprivate func getFavoriteFilms() {
        NetworkWeatherManager.shared.fetchCurrent(baseUrl: Constants.shared.upcomingURL) { films in
            StorageManager.shared.saveAll(films: films)
            let favoriteFilmsLoad = StorageManager.shared.load()
            self.favoriteFilms = favoriteFilmsLoad.filter { $0.isLike == true }
            self.tableView.reloadData()
        }
    }
    
}

extension FavoriteFilmsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFilms.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteFilmCell.indetifier, for: indexPath) as? FavoriteFilmCell else { return UITableViewCell() }
        cell.delegate = self
        cell.selectionStyle = .none
        let film = favoriteFilms[indexPath.row]
        cell.film = film
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ok")
    }
}

//MARK: - extension to FavoriteFilmCellProtocol

extension FavoriteFilmsController: FavoriteFilmCellProtocol {
    func removeFilm() {
        getFavoriteFilms()
    }
    
    
}
