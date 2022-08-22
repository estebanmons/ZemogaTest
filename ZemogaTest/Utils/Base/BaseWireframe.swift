//
//  BaseWireframe.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import UIKit

protocol WireframeInterface: AnyObject {
    func showAlertWithAction(_ title: String, message: String, handler: @escaping () -> Void)
}

extension WireframeInterface {
    
    func showAlertWithAction(_ title: String, message: String, handler: @escaping () -> Void) {
        showAlertWithAction(title, message: message, handler: handler)
    }
}

class BaseWireframe {

    private unowned var _viewController: UIViewController

    // We need it in order to retain the view controller reference upon first access
    private var temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

extension BaseWireframe: WireframeInterface {
    
    func showAlertWithAction(
        _ title: String,
        message: String,
        handler: @escaping () -> Void
    ) {
        self.viewController.showAlertWithActions(title, message: message, handler: handler)
    }
}

extension BaseWireframe {

    var viewController: UIViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}

extension UIViewController {

    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
    func showAlertWithActions(
        _ title: String,
        message: String,
        handler: @escaping () -> Void
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.Alert.accept, style: .cancel, handler: { _ in
            handler()
        })
        alertController.addAction(action)
        DispatchQueue.main.async(execute: {
            self.present(alertController, animated: true, completion: nil)
        })
    }
}

extension UINavigationController {

    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
