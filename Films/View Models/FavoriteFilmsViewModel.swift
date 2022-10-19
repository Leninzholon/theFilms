//
//  FavoriteFilmsViewModel.swift
//  Films
//
//  Created by apple on 19.10.2022.
//

import UIKit

struct FavoriteFilmsViewModel {
    private var films : [Film]
}

extension FavoriteFilmsViewModel {
    init(_ film : [Film]) {
//        let films = CoreDataManager.shared.fetchFilm()
        self.films = film
    }
}

extension FavoriteFilmsViewModel {
    func returnFilms() -> [Film]{
        return films
    }
}
extension FavoriteFilmsViewModel {
    func numberOfRowsInSection() -> Int {
        return films.count
    }
}

extension FavoriteFilmsViewModel {
    func favoritFilmAtIndex(index: Int) -> FavoriteFilmViewModel {
        let film = films[index]
        return FavoriteFilmViewModel(film)
    }
}

struct FavoriteFilmViewModel {
    private var film: Film
}

extension FavoriteFilmViewModel {
    init(_ film: Film){
        self.film = film
    }
}


extension FavoriteFilmViewModel {
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
