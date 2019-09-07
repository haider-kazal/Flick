//
//  Presentable.swift
//  Flick
//
//  Created by Haider Kazal on 6/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController { get }
}

extension UIViewController: Presentable {
    var toPresent: UIViewController { return self }
}
