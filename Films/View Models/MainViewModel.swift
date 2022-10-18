//
//  MainViewModel.swift
//  Films
//
//  Created by apple on 17.10.2022.
//

import UIKit

struct MainListViewModel {
   private var films : [MainFilmModel]
}


extension MainListViewModel {
    init(_ films: [MainFilmModel]) {
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
     private var film: MainFilmModel
}

extension MainViewModel {
    init(_ film: MainFilmModel) {
        self.film = film
    }
}

extension MainViewModel {
    var title : String {
        return self.film.title
    }
    var description : String {
        return self.film.description
    }
    var urlString: String {
        return film.urlString
    }
    var islake: Bool {
        return film.isLike
    }
    var id: Int {
        return film.id
    }
    
    mutating func changeIsLike() {
        film.isLike = !film.isLike
    }
}


