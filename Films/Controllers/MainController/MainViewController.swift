//
//  ViewController.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit

class MainViewController: UICollectionViewController {
    //MARK: - Properties
    private var viewModel: MainListViewModel?
    //MARK: - live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingCollectionView()
        NetworkWeatherManager.shared.fetchCurrent(baseUrl: Constants.shared.upcomingURL) { films in
            if !films.isEmpty { CoreDataManager.shared.saveFilms(resultFilm: films) }
            self.viewModel = MainListViewModel(CoreDataManager.shared.fetchFilm())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setInterfaseNavigationBar()
    }
    
    //MARK: - helper func
    fileprivate func setInterfaseNavigationBar() {
        title = "Popular film"
    }
    fileprivate func setupSettingCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FilmViewCell.self, forCellWithReuseIdentifier: FilmViewCell.identifier)
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: FilmViewCell.identifier, for: indexPath) as? FilmViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        guard let viewModel = viewModel else { return  UICollectionViewCell() }
        let film = viewModel.fimlAtIndex(indexPath.row)
        cell.viewModel = film
        cell.configureCell(with: film)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 2 - 5, height: 150)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetaillController()
        guard let viewModel = viewModel else { return }
        detailController.filmInfo = viewModel.fimlAtIndex(indexPath.row)
        navigationController?.pushViewController(detailController, animated: true)
    }
}


//MARK: - ecstensions

extension MainViewController: FilmViewCellProtocol {
    func resetLike(film: MainViewModel) {
        NotificationCenter.default.post(name: .internetDown, object: nil, userInfo: nil)
        NetworkWeatherManager.shared.fetchCurrent(baseUrl: Constants.shared.upcomingURL) { films in
            StorageManager.shared.saveAll(films: films)
            let currentFilms = CoreDataManager.shared.fetchFilm()
            self.viewModel = MainListViewModel(currentFilms)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }    }
    
  
    
}
