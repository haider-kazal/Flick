//
//  DiscoverViewHeaderCollectionReusableView.swift
//  Flick
//
//  Created by Haider Ali Kazal on 18/12/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

final class DiscoverViewHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "\(DiscoverViewHeaderCollectionReusableView.self)"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        addSubview(titleLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configureWith(sectionType: DiscoverViewModelSection) {
        titleLabel.text = sectionType.title
    }
}
