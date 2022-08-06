//
//  AllPostsViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Антон Голубейков on 04.08.2022.
//

import UIKit

class AllPostsViewController: UIViewController {
    //MARK: - Constants
    private enum Constants {
        static let collectionViewPadding: CGFloat = 16
        static let hSpaceBetweenItems: CGFloat = 7
        static let vSpaceBetweenItems: CGFloat = 8
    }
    //MARK: - Private properties
    private let postModel: AllPostsModel = .init()
    
    //MARK: - Views
    @IBOutlet private weak var allPostsCollectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearence()
        configureModel()
        postModel.getPosts()
    }
}

//MARK: - Private methods
private extension AllPostsViewController {
    func configureAppearence() {
        allPostsCollectionView.register(UINib(nibName: "\(AllPostsCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(AllPostsCollectionViewCell.self)")
        allPostsCollectionView.dataSource = self
        allPostsCollectionView.delegate = self
        allPostsCollectionView.contentInset = .init(top: 10, left: 16, bottom: 10, right: 16)
    }
    func configureModel() {
        postModel.didPostsUpdated = { [weak self] in
            self?.allPostsCollectionView.reloadData()
        }
    }
    
    
}

//MARK: - UICollection

extension AllPostsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = allPostsCollectionView.dequeueReusableCell(withReuseIdentifier: "\(AllPostsCollectionViewCell.self)", for: indexPath)
        if let cell = cell as? AllPostsCollectionViewCell {
            cell.titleText = postModel.posts[indexPath.item].title
            cell.isFavorite = postModel.posts[indexPath.item].isFavorite
            cell.image = postModel.posts[indexPath.item].image
            cell.didFavoriteTap = { [weak self] in
                self?.postModel.posts[indexPath.item].isFavorite.toggle()
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (view.frame.width - Constants.collectionViewPadding * 2 - Constants.hSpaceBetweenItems) / 2
        return CGSize(width: itemWidth, height: itemWidth / 168 * 246)
    
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.vSpaceBetweenItems
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.hSpaceBetweenItems
    }
}
