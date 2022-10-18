//
//  MainFilmModel.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import Foundation


struct MainFilmModel: Codable {
    var id: Int
    var title: String {
        didSet {
            if  StorageManager.shared.getFavoriteStatus(for: title) {
                isLike = true
            }
        }
    }
    let description: String
    let urlString: String
    var isLike: Bool = false {
        didSet {
            StorageManager.shared.setFavoriteStatus(for: title, with: isLike)
        }
    }
    let isVideo: Bool
    init(model: Result) {
        id = model.id
        title = model.title
        description = model.overview
        urlString = model.posterPath
        isVideo = model.video
    }
}
