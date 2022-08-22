//
//  PostInteractor.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

final class PostDetailInteractor {
    
    // MARK: - Private properties -
    private lazy var apiManager = APIManager()
}

// MARK: - Extensions -
extension PostDetailInteractor: PostDetailInteractorInterface {
    
    func requestGetUser(id: Int, completionHandler: @escaping (PostUserRsult) -> Void) {
        apiManager.request(parameters: EmptyRequest(), endpoint: .getUser(id: id)) { (result: Result<User>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .error:
                completionHandler(.error)
            }
        }
    }
    
    func requestGetPostComments(id: Int, completionHandler: @escaping (PostCommentsResult) -> Void) {
        apiManager.request(parameters: EmptyRequest(), endpoint: .getPostComments(id: id)) { (result: Result<[Comment]>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
