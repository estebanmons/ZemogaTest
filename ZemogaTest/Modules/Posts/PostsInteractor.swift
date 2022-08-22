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
extension PostsInteractor: PostsInteractorInterface {
    
    func requestGetPost(completionHandler: @escaping (PostsResult) -> Void) {
        apiManager.request(parameters: EmptyRequest(), endpoint: .getPosts) { (result: Result<[Post]>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
