//
//  BaseView.swift
//  Flick
//
//  Created by Haider Kazal on 12/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

class BaseView<ViewModel>: UIView, ViewModelBased {
    var viewModel: ViewModel
    
    required init?(coder: NSCoder) {
        fatalError("Use .init(with:) instead")
    }
    
    private override init(frame: CGRect) {
        fatalError("Use .init(with:) instead")
    }
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    func setupViews() { }
    
    func setupConstraints() { }
}
