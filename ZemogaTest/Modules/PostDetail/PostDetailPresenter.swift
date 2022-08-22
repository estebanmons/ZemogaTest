//
//  PostDetailPresenter.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

struct PostDetailModel {
    var description: String
    var email: String
    var name: String
    var phone: String
    var title: String
    var website: String
    
    init(
        description: String,
        email: String = Constants.emptyString,
        name: String = Constants.emptyString,
        phone: String = Constants.emptyString,
        title: String,
        website: String = Constants.emptyString
    ) {
        self.description = description
        self.email = email
        self.name = name
        self.phone = phone
        self.title = title
        self.website = website
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
        var model = PostDetailModel(description: post.body, title: Constants.PostDetail.description)
        
        let userOperation = AsyncBlockOperation { [weak self] operation in
            guard let strongSelf = self else {
                operation.complete()
                return
            }
            
            strongSelf.interactor.requestGetUser(id: post.userId) { result in
                switch result {
                case .success(let user):
                    model.name = user.name
                    model.email = user.email
                    model.phone = user.phone
                    model.email = user.email
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
    
    func viewDidLoad() {
        getDetailPost()
    }
}
