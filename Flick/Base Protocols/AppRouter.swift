//
//  Router.swift
//  Flick
//
//  Created by Haider Kazal on 6/9/19.
//  Copyright © 2019 Haider Ali Kazal. All rights reserved.
//

import UIKit

protocol AppRouter: Presentable {
    func present(viewController: Presentable, withAnimation isAnimated: Bool, onCompletion completionHandler: (() -> Void)?)
    func dismiss(withAnimation isAnimated: Bool, onCompletion completionHandler: (() -> Void)?)
    
    func push(viewController: Presentable, withAnimation isAnimated: Bool, hidingBottomBar shouldHideBottomBar: Bool, onCompletion completionHandler: (() -> Void)?)
    func pop(withAnimation isAnimated: Bool)
    func popToRoot(withAnimation isAnimated: Bool)
    
    func changeRootTo(viewController: Presentable, withAnimation isAnimated: Bool, hidingNavigationBar shouldHideNavigationBar: Bool)
}

final class DefaultAppRouter: AppRouter {
    private lazy var completionHandlers: [UIViewController: (() -> Void)?] = [:]
    private weak var rootNavigationController: UINavigationController?
    
    var toPresent: UIViewController { return rootNavigationController! }
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func present(viewController: Presentable, withAnimation isAnimated: Bool, onCompletion completionHandler: (() -> Void)?) {
        rootNavigationController?.present(viewController.toPresent, animated: isAnimated, completion: completionHandler)
    }
    
    func dismiss(withAnimation isAnimated: Bool, onCompletion completionHandler: (() -> Void)?) {
        rootNavigationController?.dismiss(animated: isAnimated, completion: completionHandler)
    }
    
    func push(viewController: Presentable, withAnimation isAnimated: Bool, hidingBottomBar shouldHideBottomBar: Bool, onCompletion completionHandler: (() -> Void)?) {
        precondition(!(viewController.toPresent is UINavigationController), "Cannot push UINavigationController as Presentable")
        
        rootNavigationController?.hidesBottomBarWhenPushed = shouldHideBottomBar
        rootNavigationController?.pushViewController(viewController.toPresent, animated: isAnimated)
    }
    
    func pop(withAnimation isAnimated: Bool) {
        guard let poppedViewController = rootNavigationController?.popViewController(animated: isAnimated) else { return }
        executecCompletionHandler(for: poppedViewController)
    }
    
    func popToRoot(withAnimation isAnimated: Bool) {
        guard let poppedViewControllers = rootNavigationController?.popToRootViewController(animated: isAnimated) else { return }
        
        poppedViewControllers.forEach({ executecCompletionHandler(for: $0) })
    }
    
    func changeRootTo(viewController: Presentable, withAnimation isAnimated: Bool = false, hidingNavigationBar shouldHideNavigationBar: Bool) {
        rootNavigationController?.setViewControllers([viewController.toPresent], animated: isAnimated)
        rootNavigationController?.isNavigationBarHidden = shouldHideNavigationBar
    }
    
    private func executecCompletionHandler(for viewController: UIViewController) {
        guard let completionHandler = completionHandlers[viewController] else { return }
        completionHandler?()
        completionHandlers.removeValue(forKey: viewController)
    }
}
