//
//  PostDetailPresenter.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostDetailPresenter {

    // MARK: - Private properties -
    private unowned let view: PostDetailViewInterface
    private let interactor: PostDetailInteractorInterface
    private let wireframe: PostDetailWireframeInterface

    // MARK: - Lifecycle -
    init(
        view: PostDetailViewInterface,
        interactor: PostDetailInteractorInterface,
        wireframe: PostDetailWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -
extension PostDetailPresenter: PostDetailPresenterInterface { }
