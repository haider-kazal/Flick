//
//  BaseViewModel.swift
//  Flick
//
//  Created by Haider Kazal on 28/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

protocol BaseViewModel {
    associatedtype Services
    init(with services: Services)
}
