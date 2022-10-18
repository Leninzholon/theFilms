//
//  DetaillController.swift
//  Films
//
//  Created by apple on 14.10.2022.
//

import Foundation
import UIKit
import SDWebImage
import AVKit


class DetaillController: UIViewController {
    var filmInfo : MainViewModel? {
        didSet {
            titleLabel.text = filmInfo?.title
            descriptionText.text = filmInfo?.description
            guard let stringURL = filmInfo?.urlString else { return }
            guard let url = URL(string: Constants.shared.forLoadImageURL + stringURL ) else { return }
            filmImage.sd_setImage(with: url)
        }
    }
    lazy var filmImage : UIImageView = {
        let iv = UIImageView()
        iv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleVideo))
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(tap)
        return iv
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()
    let descriptionText: UITextView = {
       let tv = UITextView()
        tv.text = "Description"
        tv.font = .systemFont(ofSize: 16, weight: .light)
//        tv.heightAnchor.constraint(equalToConstant: 200).isActive = true
        tv.isEditable = false
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       let stackView = UIStackView(arrangedSubviews: [
       filmImage,
       titleLabel
       ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingRight: 40)
        stackView.centerX(inView: view)
        view.addSubview(descriptionText)
        descriptionText.anchor(top: stackView.bottomAnchor, left: view.leftAnchor, botton: view.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    }
    @objc func handleVideo() {
        let videoController = YoutubeController()
        videoController.film = filmInfo
        navigationController?.pushViewController(videoController, animated: true)
    }
}
