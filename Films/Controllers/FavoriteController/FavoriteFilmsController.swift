//
//  FavoriteFilmsController.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit

class FavoriteFilmsController: UITableViewController {
    //MARK: - Properties
    var viewModel = FavoriteFilmsViewModel([])
    //MARK: - livecycle
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FavoriteFilmCell.self, forCellReuseIdentifier: FavoriteFilmCell.indetifier)
        getFavoriteFilms()
        setupNotification()
        setupInterfiseNavigationBar()
    }
    deinit {
         NotificationCenter.default.removeObserver(self)
     }
    //MARK: - selector func
    @objc func keyboardWillShow(){
        getFavoriteFilms()
       }
    //MARK: -  helper func
    fileprivate func setupInterfiseNavigationBar() {
        title = "Favorite film"
    }
    fileprivate func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .internetDown, object: nil)
        
    }
    fileprivate func getFavoriteFilms() {
        NetworkWeatherManager.shared.fetchCurrent(baseUrl: Constants.shared.upcomingURL) { films in
            let favoriteFilmsLoad = CoreDataManager.shared.fetchFilm()
            self.viewModel = FavoriteFilmsViewModel(favoriteFilmsLoad.filter { $0.isLike == true })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
extension FavoriteFilmsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteFilmCell.indetifier, for: indexPath) as? FavoriteFilmCell else { return UITableViewCell() }
        cell.delegate = self
        cell.selectionStyle = .none
        let film = viewModel.favoritFilmAtIndex(index: indexPath.row)
        cell.viewModel = film
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoriteFilmCell.height
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
