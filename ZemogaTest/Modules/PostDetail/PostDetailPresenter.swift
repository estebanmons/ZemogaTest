//
//  PostDetailPresenter.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

struct PostDetailModel {
    var commentsTitle: String
    var description: String
    var descriptionTitle: String
    var email: String
    var name: String
    var phone: String
    var userTitle: String
    var website: String
    
    init(
        commentsTitle: String = Constants.emptyString,
        description: String,
        descriptionTitle: String,
        email: String = Constants.emptyString,
        name: String = Constants.emptyString,
        phone: String = Constants.emptyString,
        website: String = Constants.emptyString,
        userTitle: String = Constants.emptyString
    ) {
        self.commentsTitle = commentsTitle
        self.description = description
        self.descriptionTitle = descriptionTitle
        self.email = email
        self.name = name
        self.phone = phone
        self.website = website
        self.userTitle = userTitle
    }
}

final class PostDetailPresenter {

    // MARK: - Private properties -
    private unowned let view: PostDetailViewInterface
    private let interactor: PostDetailInteractorInterface
    private let wireframe: PostDetailWireframeInterface
    
    private let post: Post?
    private var postComments = [Comment]()

    // MARK: - Lifecycle -
    init(
        view: PostDetailViewInterface,
        interactor: PostDetailInteractorInterface,
        wireframe: PostDetailWireframeInterface,
        post: Post? = nil
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.post = post
    }
    
    private func getDetailPost() {
        guard let post = post else { return }
        let queue = OperationQueue()
        var model = PostDetailModel(description: post.body, descriptionTitle: Constants.PostDetail.description)
        
        let userOperation = AsyncBlockOperation { [weak self] operation in
            guard let strongSelf = self else {
                operation.complete()
                return
            }
            
            strongSelf.interactor.requestGetUser(id: post.userId) { result in
                switch result {
                case .success(let user):
                    model.userTitle = Constants.PostDetail.user
                    model.name = user.name
                    model.email = user.email
                    model.phone = user.phone
                    model.website = user.website
                case .error:
                    break
                }
                operation.complete()
            }
        }
        
        let commentsOperation = AsyncBlockOperation { [weak self] operation in
            guard let strongSelf = self else {
                operation.complete()
                return
            }
            
            strongSelf.interactor.requestGetPostComments(id: post.id) { result in
                switch result {
                case .success(let comments):
                    model.commentsTitle = Constants.PostDetail.comments
                    strongSelf.postComments = comments
                case .error:
                    break
                }
                operation.complete()
            }
        }
        
        let viewOperation = AsyncBlockOperation { [weak self] operation in
            guard let strongSelf = self else {
                operation.complete()
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.view.setModelData(with: model)
            }
            operation.complete()
        }
        
        commentsOperation.addDependency(userOperation)
        viewOperation.addDependency(commentsOperation)
        queue.addOperations([userOperation, commentsOperation, viewOperation], waitUntilFinished: false)
    }
}

// MARK: - Extensions -
extension PostDetailPresenter: PostDetailPresenterInterface {
    
    var isFavorite: Bool {
        guard let post = post else { return false }
        return interactor.dataManager.containFavorite(id: post.id)
    }
    
    var numberOfItems: Int {
        postComments.count
    }
    
    func viewDidLoad() {
        getDetailPost()
    }
    
    func setComment(at row: Int) -> String {
        return postComments[row].body
    }
    
    func validateFavorite() {
        guard let post = post else { return }
        if interactor.dataManager.containFavorite(id: post.id) {
            interactor.dataManager.removeFavorite(id: post.id)
        } else {
            interactor.dataManager.saveFavorite(post: post)
        }
    }
}
