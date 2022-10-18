//
//  NetworkService.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit

import UIKit
import Kingfisher



struct NetworkWeatherManager {
    static let shared = NetworkWeatherManager()
    func fetchCurrent(baseUrl: String, complition: @escaping ([Result]) -> ()) {
        let urlString =  "https://api.themoviedb.org/3/movie/upcoming?api_key=8983d582e6db4d50746d8e03ec9e79f5"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let decoder = JSONDecoder()
                do {
                    let currentData = try decoder.decode(FilmModel.self, from: data!)
                    print(currentData.results.first?.title ?? "nil data")
                    let result = currentData.results
                    DispatchQueue.main.async {
                        complition(result)
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            
            }
        }
        
        task.resume()

   

   

    }
    func fetchCurrentVideo(id: String, complitionHeandler: @escaping ((String) -> ())) {
        let urlString = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=8983d582e6db4d50746d8e03ec9e79f5"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let currentData = try decoder.decode(TrailerModel.self, from: data)
                    guard let key = currentData.results?.first?.key else { return }
                    complitionHeandler(key)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

