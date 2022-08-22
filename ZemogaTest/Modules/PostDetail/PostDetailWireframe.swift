//
//  PostDetailWireframe.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostDetailWireframe: BaseWireframe {

    // MARK: - Module setup -
    init(post: Post) {
        let moduleViewController = PostDetailViewController()
        super.init(viewController: moduleViewController)

        let interactor = PostDetailInteractor()
        let presenter = PostDetailPresenter(view: moduleViewController, interactor: interactor, wireframe: self, post: post)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -
extension PostDetailWireframe: PostDetailWireframeInterface { }
