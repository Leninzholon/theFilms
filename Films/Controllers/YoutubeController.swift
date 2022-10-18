//
//  YoutubeController.swift
//  Films
//
//  Created by apple on 16.10.2022.
//

import UIKit
import YouTubeiOSPlayerHelper


class YoutubeController: UIViewController {
    var film: MainViewModel? {
        didSet {
            guard let film = film else {
                return
            }
            NetworkWeatherManager.shared.fetchCurrentVideo(id: String(film.id)) { [weak self] id in
                DispatchQueue.main.async {
                        self?.videoView.load(withVideoId: id)
                }
            }
        }
    }
    let videoView : YTPlayerView = {
        let player = YTPlayerView()
        
        return player
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(videoView)
        videoView.anchor( width: view.frame.width, height: 350)
        videoView.centerX(inView: view)
        videoView.centerY(inView: view)
    }
}
