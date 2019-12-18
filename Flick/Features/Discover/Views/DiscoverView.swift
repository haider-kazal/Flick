//
//  DiscoverView.swift
//  Flick
//
//  Created by Haider Kazal on 12/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Kingfisher
import UIKit

final class DiscoverView: BaseView<DiscoverViewModel> {
    private let movieCellReuseIdentifier = "\(DiscoverMovieTableViewCell.self)"
    private let tvShowCellReuseIdentifier = "\(DiscoverTVShowTableViewCell.self)"
    
    private(set) lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let cellMargin: CGFloat = 10

        layout.sectionInsetReference = .fromSafeArea
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellMargin
        layout.minimumLineSpacing = cellMargin
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        //layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.contentInset.left = 10
        collectionView.contentInset.right = 10
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(DiscoverViewHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DiscoverViewHeaderCollectionReusableView.identifier)
        collectionView.register(DiscoverViewCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverViewCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    weak var coordinator: DiscoverCoordinator?
    
    override func setupViews() {
        addSubview(collectionView)
        
        viewModel.updateMoviesUISection = { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }
        
        viewModel.updateTVShowsUISection = { [weak self] in
            self?.collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateCollectionViewFlowLayout(with containerSize: CGSize) {
        let cellMargin: CGFloat = 10
        
        let minItemWidth: CGFloat = 180
        let numberOfCell = containerSize.width / minItemWidth
        let width = floor((numberOfCell / floor(numberOfCell)) * minItemWidth)
        let height = ceil(width * (4.0 / 3.0))
        
        collectionViewFlowLayout.minimumInteritemSpacing = cellMargin
        collectionViewFlowLayout.minimumLineSpacing = cellMargin
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        
        collectionView.reloadData()
    }
}

extension DiscoverView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfElements(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DiscoverViewHeaderCollectionReusableView.identifier, for: indexPath) as! DiscoverViewHeaderCollectionReusableView
        
        precondition(DiscoverViewModelSection(rawValue: indexPath.section) != nil, "Invalid section")
        let cellSection = DiscoverViewModelSection(rawValue: indexPath.section)!
        
        view.configureWith(sectionType: cellSection)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        precondition(DiscoverViewModelSection(rawValue: indexPath.section) != nil, "Invalid section")
        let cellSection = DiscoverViewModelSection(rawValue: indexPath.section)!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverViewCollectionViewCell.identifier, for: indexPath) as! DiscoverViewCollectionViewCell
        
        switch cellSection {
        case .movies:
            let movie = viewModel.moviesViewModel[indexPath.item].movie
            cell.configureWith(data: movie)
            
        case .tvShows:
            let tvShow = viewModel.tvShowsViewModel[indexPath.item].tvShow
            cell.configureWith(data: tvShow)
        }
        
        return cell
    }
}

extension DiscoverView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        precondition(DiscoverViewModelSection(rawValue: indexPath.section) != nil, "Invalid section")
        let cellSection = DiscoverViewModelSection(rawValue: indexPath.section)!
        
        switch cellSection {
        case .movies:
            let movie = viewModel.moviesViewModel[indexPath.item].movie
            coordinator?.showDetails(for: movie)
            
        case .tvShows:
            let tvShow = viewModel.tvShowsViewModel[indexPath.item].tvShow
            coordinator?.showDetails(for: tvShow)
        }
    }
}

extension DiscoverView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let posterURLs = indexPaths.compactMap({ viewModel.tvShowsViewModel[existAt: $0.item]?.tvShow.posterURL })
        posterURLs.forEach({ KingfisherManager.shared.retrieveImage(with: $0, completionHandler: nil) })
        
        let backdropURLs = indexPaths.compactMap({ viewModel.tvShowsViewModel[existAt: $0.item]?.tvShow.backdropURL })
        backdropURLs.forEach({ KingfisherManager.shared.retrieveImage(with: $0, completionHandler: nil) })
    }
}
