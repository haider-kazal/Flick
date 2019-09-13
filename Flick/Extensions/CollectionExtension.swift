//
//  CollectionExtension.swift
//  Flick
//
//  Created by Haider Kazal on 13/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import Foundation

extension Collection {
    subscript(existAt index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
