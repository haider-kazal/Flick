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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.numberOfLines = 5
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
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 85),
            posterImageView.heightAnchor.constraint(equalToConstant: 132),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: overviewLabel.topAnchor, constant: -10)
            //titleLabel.bottomAnchor.constraint(equalTo: overviewLabel.topAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        overviewLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
}
