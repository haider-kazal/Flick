//
//  BaseViewController.swift
//  Flick
//
//  Created by Haider Kazal on 28/8/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

class BaseViewController<View: UIView, ViewModel>: UIViewController, BaseController, ViewBased, ViewModelBased {
    var rootView: View
    var viewModel: ViewModel
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use .init(with:) instead")
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use .init(with:) instead")
    }
    
    init(with view: View, and viewModel: ViewModel) {
        rootView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        willDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappear()
    }
}

