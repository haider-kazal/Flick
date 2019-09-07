//
//  ViewModelBased.swift
//  Flick
//
//  Created by Haider Kazal on 28/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol ViewModelBased: class {
    associatedtype ViewModel
    var viewModel: ViewModel { get }
}
