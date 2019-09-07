//
//  BaseController.swift
//  Flick
//
//  Created by Haider Kazal on 28/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol BaseController {
    func didLoad()
    
    func willAppear()
    func didAppear()
    
    func willDisappear()
    func didDisappear()
}

extension BaseController where Self: UIViewController {
    func didLoad() {
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = .white
    }
    
    func willAppear() { }
    func didAppear() { }
    
    func willDisappear() { }
    func didDisappear() { }
}
