//
//  PostsPresenter.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostsPresenter {

    // MARK: - Private properties -
    private unowned let view: PostsViewInterface
    private let interactor: PostsInteractorInterface
    private let wireframe: PostsWireframeInterface

    // MARK: - Lifecycle -
    init(
        view: PostsViewInterface,
        interactor: PostsInteractorInterface,
        wireframe: PostsWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -
extension PostsPresenter: PostsPresenterInterface { }
