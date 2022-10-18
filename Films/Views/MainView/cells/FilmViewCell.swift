//
//  FilmViewCell.swift
//  Films
//
//  Created by apple on 13.10.2022.
//

import UIKit
import SDWebImage

protocol FilmViewCellProtocol: AnyObject {
    func resetLike(film: MainViewModel)
}

class FilmViewCell: UICollectionViewCell {
    weak var delegate: FilmViewCellProtocol?
    static let identifier = "FilmViewCell"
    let filmImage : UIImageView = {
       let image = UIImageView()
        return image
    }()
    let likeImage : UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(systemName: "heart.circle")
        iv.tintColor = .red
        return iv
    }()
    let titleFilmLabel : UILabel = {
       let label = UILabel()
        label.text = "Film title"
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    var viewModel: MainViewModel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        backgroundColor = .green
        addGesture() 
addSubview(filmImage)
        self.filmImage.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor,  paddingTop: 5, paddingLeft: 5, paddingRight: 5,  height: 100)
addSubview(likeImage)
        likeImage.anchor(top: filmImage.topAnchor, right: filmImage.rightAnchor, width: 40, height: 40)
addSubview(titleFilmLabel)
        titleFilmLabel.anchor(top: filmImage.bottomAnchor, left: self.leftAnchor, botton: self.bottomAnchor, right: self.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingBotton: 5, paddingRight: 16)
        
    }
private func addGesture() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleLikeTepped))
    likeImage.isUserInteractionEnabled = true
    likeImage.addGestureRecognizer(tap)
    }
    func configureCell(with model: MainViewModel) {
        titleFilmLabel.text = model.title
        guard let path = URL(string: Constants.shared.forLoadImageURL + model.urlString) else { return }
        filmImage.sd_setImage(with: path)
        likeImage.tintColor = viewModel.islake ? .red : .white

    }
    
    //MARK: - selector func
    @objc private func handleLikeTepped() {
        print("DEBAG: handleLikeTepped()")
        viewModel.changeIsLike()
        delegate?.resetLike(film: viewModel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
