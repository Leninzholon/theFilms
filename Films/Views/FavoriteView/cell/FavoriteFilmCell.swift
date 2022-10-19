//
//  FavoriteFilmCell.swift
//  Films
//
//  Created by apple on 15.10.2022.
//

import UIKit
import SDWebImage



protocol FavoriteFilmCellProtocol: AnyObject {
    func removeFilm()
}
class FavoriteFilmCell: UITableViewCell, UITextViewDelegate  {
    //MARK: - Properties
    static let height: CGFloat = 200
    weak var delegate: FavoriteFilmCellProtocol?
    static let indetifier = "FavoriteFilmCell"
    var viewModel: FavoriteFilmViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.overview
            guard let stringUrl = viewModel?.urlString else { return }
            guard let url = URL(string: Constants.shared.forLoadImageURL + stringUrl) else { return }
            filmImage.sd_setImage(with: url)
        }
    }
    lazy var deleteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        button.tintColor = .black
        button.backgroundColor = .white
        return button
    }()
    let filmImage : UIImageView = {
       let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.clipsToBounds = true
        return iv
    }()
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    let descriptionLabel : UITextView = {
       let label = UITextView()
        label.text = "Description"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.isEditable = false
        return label
    }()
    //MARK: - helpers func
    @objc  func handleDelete() {
        print("DEBAG: trash..")
       

        viewModel?.changeIsLike()
//        StorageManager.shared.setFavoriteStatus(for: viewModel?.title!, with: viewModel.isLike)
        delegate?.removeFilm()
    }
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = .red
        descriptionLabel.delegate = self
        self.addSubview(filmImage)
        filmImage.anchor(top: topAnchor, left: leftAnchor,  paddingTop: 20, paddingLeft: 20, width: 100, height: 100)
        filmImage.bringSubviewToFront(contentView)
        self.addSubview(deleteButton)
        deleteButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 8, paddingRight: 8, width: 40, height: 40)
        self.addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: filmImage.rightAnchor, right: deleteButton.leftAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 10)
       
        self.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: titleLabel.bottomAnchor, left: filmImage.rightAnchor, botton: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
