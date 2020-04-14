//
//  DiscoverTableViewCell.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Kingfisher
import UIKit

final class DiscoverMovieTableViewCell: BaseTableViewCell<TMDbDiscoverMovie> {
    private lazy var rootView: DiscoverTableViewCellView = {
        let view = DiscoverTableViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        rootView.setupView()
        contentView.addSubview(rootView)
        
    }
    
    override func setupConstraints() {
        super.setupView()
        rootView.setupConstraints()
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func configureWith(data: TMDbDiscoverMovie) {
        rootView.titleLabel.text = data.title
        rootView.overviewLabel.text = data.overview
        rootView.posterImageView.kf.indicatorType = .activity
        rootView.posterImageView.kf.setImage(with: data.posterURL)
    }
}

final class DiscoverTVShowTableViewCell: BaseTableViewCell<TMDbDiscoverTVShow> {
    private lazy var rootView: DiscoverTableViewCellView = {
        let view = DiscoverTableViewCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        rootView.setupView()
        contentView.addSubview(rootView)
        
    }
    
    override func setupConstraints() {
        super.setupView()
        rootView.setupConstraints()
        
        NSLayoutConstraint.activate([
            rootView.topAnchor.constraint(equalTo: contentView.topAnchor),
            rootView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            rootView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rootView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func configureWith(data: TMDbDiscoverTVShow) {
        rootView.titleLabel.text = data.name
        rootView.overviewLabel.text = data.overview
        rootView.posterImageView.kf.indicatorType = .activity
        rootView.posterImageView.kf.setImage(with: data.posterURL)
    }
}

class DiscoverTableViewCellView: UIView {
    private(set) lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //posterImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 85),
//            posterImageView.heightAnchor.constraint(equalToConstant: 132),
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: overviewLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        overviewLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        posterImageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        overviewLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        posterImageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        posterImageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        overviewLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        posterImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
