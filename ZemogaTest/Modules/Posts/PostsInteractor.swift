//
//  PostsInteractor.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostsInteractor {
    
    // MARK: - Private properties -
    private lazy var apiManager = APIManager()
}

// MARK: - Extensions -
extension PostsInteractor: PostsInteractorInterface { }
