//
//  PostDetailInterfaces.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

enum PostUserRsult {
    case success(User)
    case error
}

enum PostCommentsResult {
    case success([Comment])
    case error
}

protocol PostDetailWireframeInterface: WireframeInterface { }

protocol PostDetailViewInterface: ViewInterface {
    func setModelData(with model: PostDetailModel)
}

protocol PostDetailPresenterInterface: PresenterInterface {
    var isFavorite: Bool { get }
    var numberOfItems: Int { get }
    func setComment(at row: Int) -> String
    func validateFavorite()
}

protocol PostDetailInteractorInterface: InteractorInterface {
    var dataManager: DataManager { get }
    func requestGetUser(id: Int, completionHandler: @escaping (PostUserRsult) -> Void)
    func requestGetPostComments(id: Int, completionHandler: @escaping (PostCommentsResult) -> Void)
}
