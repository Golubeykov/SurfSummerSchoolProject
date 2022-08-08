//
//  AllPostsCollectionViewCell.swift
//  SurfSummerSchoolProject
//
//  Created by Антон Голубейков on 05.08.2022.
//

import UIKit

class AllPostsCollectionViewCell: UICollectionViewCell {
    //MARK: - Constants
    private enum Constants {
        static let favoriteTapped = UIImage(named: "favoriteTapped")
        static let favoriteUntapped = UIImage(named: "favoriteUntapped")
    }
    
    //MARK: - Views
    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postTextLabel: UILabel!
    @IBOutlet private weak var favoritePostButtonLabel: UIButton!
    
    
    //MARK: - Events
    var didFavoriteTap: (() -> Void)?
    
    //MARK: - Calculated
    var buttonImage: UIImage? {
        return isFavorite ? Constants.favoriteTapped : Constants.favoriteUntapped
    }
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.contentView.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
            }
        }
    }
    
    //MARK: - Properties
    var titleText: String = "Test" {
        didSet {
            postTextLabel.text = titleText
        }
    }
    var imageUrlInString: String = "" {
        didSet {
            guard let url = URL(string: imageUrlInString) else {
                 return
             }
             postImageView.loadImage(from: url)
        }
    }
    var isFavorite = false {
        didSet {
            favoritePostButtonLabel.setImage(buttonImage, for: .normal)
        }
    }
    
    //MARK: - Action
    @IBAction func favoritePostButtonAction(_ sender: UIButton) {
        didFavoriteTap?()
        isFavorite.toggle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
}

//MARK: - Private methods
private extension AllPostsCollectionViewCell {
    func configureCell() {
        postTextLabel.textColor = .black
        postTextLabel.font = .systemFont(ofSize: 12)
        
        postImageView.layer.cornerRadius = 12
        
        favoritePostButtonLabel.tintColor = .white
        isFavorite = false
    }
}

