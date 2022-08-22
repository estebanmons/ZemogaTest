//
//  PostDetailWireframe.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostDetailWireframe: BaseWireframe {

    // MARK: - Module setup -
    init() {
        let moduleViewController = PostDetailViewController()
        super.init(viewController: moduleViewController)

        let interactor = PostDetailInteractor()
        let presenter = PostDetailPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -
extension PostDetailWireframe: PostDetailWireframeInterface { }
