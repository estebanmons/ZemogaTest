//
//  PostsWireframe.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostsWireframe: BaseWireframe {

    // MARK: - Module setup -
    init() {
        let moduleViewController = PostsViewController()
        super.init(viewController: moduleViewController)

        let interactor = PostsInteractor()
        let presenter = PostsPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -
extension PostsWireframe: PostsWireframeInterface {
    
    func goToDetail() {
        navigationController?.pushWireframe(PostDetailWireframe())
    }
}
