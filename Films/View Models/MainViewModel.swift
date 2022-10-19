//
//  MainViewModel.swift
//  Films
//
//  Created by apple on 17.10.2022.
//

import UIKit

struct MainListViewModel {
   private var films : [Film]
}


extension MainListViewModel {
    init(_ films: [Film]) {
        self.films = films
    }
}

extension MainListViewModel {
    func numberOfRowsInSection() -> Int  {
        return self.films.count
    }
    func fimlAtIndex(_ index: Int) -> MainViewModel {
        let film = self.films[index]
        return MainViewModel(film)
    }
}

struct MainViewModel {
     private var film: Film
}

extension MainListViewModel {
    func setValueForViewModel(complition: @escaping (MainListViewModel) -> ()) {
        NetworkWeatherManager.shared.fetchCurrent(baseUrl: Constants.shared.upcomingURL) { films in
            if self.films.count > 0 {
                CoreDataManager.shared.saveFilms(resultFilm: films)

            }
            let currentFilms = CoreDataManager.shared.fetchFilm()
            let viewModel = MainListViewModel(currentFilms)
            complition(viewModel)

        }


    }
}
extension MainViewModel {
    init(_ film: Film) {
        self.film = film
    }
}

extension MainViewModel {
    var title : String {
        return self.film.title ?? ""
    }
    var overview : String {
        return self.film.overview ?? ""
    }
    var urlString: String {
        return film.urlString ?? ""
    }
    var islake: Bool {
        return film.isLike
    }
    var id: Int {
        return Int(film.id)
    }
    
    mutating func changeIsLike() {
        film.isLike = !film.isLike
    }
}


