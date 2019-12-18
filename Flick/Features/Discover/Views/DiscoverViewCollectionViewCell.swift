//
//  DiscoverViewCollectionViewCell.swift
//  Flick
//
//  Created by Haider Ali Kazal on 18/12/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class DiscoverViewCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(DiscoverViewCollectionViewCell.self)"
    
    private(set) lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(posterImageView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureWith(data: TMDbDiscoverMovie) {
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: data.posterURL)
    }
    
    func configureWith(data: TMDbDiscoverTVShow) {
        posterImageView.kf.indicatorType = .activity
        posterImageView.kf.setImage(with: data.posterURL)
    }
}
