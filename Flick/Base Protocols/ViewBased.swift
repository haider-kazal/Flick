//
//  ViewBased.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol ViewBased {
    associatedtype View: UIView
    var rootView: View { get }
}
