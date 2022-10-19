//
//  CoreDataManager.swift
//  Films
//
//  Created by apple on 18.10.2022.
//

import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FilmModel")
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error {
                fatalError("Login to store failed: \(error)")
            }
        }
        return container
    }()
    func saveFilms(resultFilm: [Result]) {
        var films = [MainFilmModel]()
        resultFilm.forEach { film in
            var currentFilm = MainFilmModel(model: film)
            currentFilm.isLike = StorageManager.shared.getFavoriteStatus(for: currentFilm.title)
            films.append(currentFilm)
        }
        if films.count > 0 {
            deleteObject(films: films)
        }
        films.forEach { film in
            let context = persistentContainer.viewContext
           guard let entity = NSEntityDescription.entity(forEntityName: "Film", in: context) else { return }
           let newFilm = NSManagedObject(entity: entity, insertInto: context)
           newFilm.setValue(film.title, forKey: "title")
           newFilm.setValue(film.overview, forKey: "overview")
            newFilm.setValue(film.id, forKey: "id")
            newFilm.setValue(film.isLike, forKey: "isLike")
            newFilm.setValue(film.urlString, forKey: "urlString")
           do{
            try context.save()
           } catch let err {
               print(err)
               return
           }
        }
    }
    func deleteObject(films: [MainFilmModel]) {
        films.forEach { film in
            let context = persistentContainer.viewContext
            let fechRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Film")
            fechRequest.predicate = NSPredicate(format: "title == %@", film.title)
            do {
                let result = try context.fetch(fechRequest)
                guard let film = result.first as? NSManagedObject else { return }
                context.delete(film)
                try context.save()
            }catch {
                print(error)
            }
        }
        
        
    }
    func getFavoriteStatus(title: String) -> Bool{
        let favoriteFilmsLoad = CoreDataManager.shared.fetchFilm()
        let favoriteFilms = favoriteFilmsLoad.filter{ $0.isLike == true && $0.title == title }
        return favoriteFilms.isEmpty
    }
    
    func fetchFilm() -> [Film] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Film>(entityName: "Film")
        do {
            let film = try context.fetch(fetchRequest)
            return film
        } catch let err {
            print(err.localizedDescription)
            return []
        }
    }
    
}
