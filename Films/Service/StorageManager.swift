//
//  StorageManager.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import Foundation


class StorageManager {
    
    static let shared = StorageManager()
    func saveAll(films: [Result]) {
        deleteAll()
        var newArrey = [MainFilmModel]()
        films.forEach { film in

            let currentFilm = MainFilmModel(model: film)
            newArrey.append(currentFilm)
        }
      
            var newFilms = [MainFilmModel]()
                newArrey.forEach { film in
                  let isLiked = getFavoriteStatus(for: film.title)
                    if isLiked {
                        var newfilm = film
                        newfilm.isLike = true
                        newFilms.append(newfilm)
                        UserDefaults.standard.set(encodable: newFilms, forKey: "films")

                    } else {
                        newFilms.append(film)
                        UserDefaults.standard.set(encodable: newFilms, forKey: "films")
                    }
                
            }
        }
    
    func setFavoriteStatus(for filmName: String, with status: Bool){
        UserDefaults.standard.set(status, forKey: filmName)
    }
    func getFavoriteStatus(for filnName: String) -> Bool {
        UserDefaults.standard.bool(forKey: filnName)
    }
    func saveAll(films: [MainFilmModel]) {
        deleteAll()
        var newArrey = [MainFilmModel]()
        films.forEach { film in
            newArrey.append(film)
            UserDefaults.standard.set(encodable: newArrey, forKey: "films")
        }
    }
    func save(film: MainFilmModel) {
        var filmArray = load()
        filmArray.append(film)
        UserDefaults.standard.set(encodable: filmArray, forKey: "like")
    }
    func load() -> [MainFilmModel] {
        guard let array = UserDefaults.standard.value([MainFilmModel].self, forKey: "films") else { return [] }
        return array
    }
    func delete(at index: Int) {
        var translatedArray = load()
        translatedArray.remove(at: index)
        UserDefaults.standard.set(encodable: translatedArray, forKey: "like")
    }
    func deleteAll() {
        let translatedArray = [MainFilmModel]()
        UserDefaults.standard.set(encodable: translatedArray, forKey: "like")
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
