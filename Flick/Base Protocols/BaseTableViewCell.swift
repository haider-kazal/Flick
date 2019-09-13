//
//  BaseTableViewCell.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol BaseTableViewCellBased {
    associatedtype Model
    func configureWith(data: Model)
}

class BaseTableViewCell<Model>: UITableViewCell, BaseTableViewCellBased {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    func setupView() { }
    func setupConstraints() { }
    
    func configureWith(data: Model) { }
}
