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
    
    private var allPost = [Post]()
    private var selectedSegmentedControl: SegmentedControlItems = .all

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
    
    private func getPosts() {
        interactor.requestGetPost { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let posts):
                strongSelf.allPost = posts
                strongSelf.view.reloadData()
            case .error:
                print("Error")
            }
        }
    }
}

// MARK: - Extensions -
extension PostsPresenter: PostsPresenterInterface {
    
    var favoritesPost: [Post] {
        interactor.dataManager.loadFavorites()
    }
    
    var numberOfItems: Int {
        switch selectedSegmentedControl {
        case .all: return allPost.count
        case .favorites: return favoritesPost.count
        }
    }
    
    func viewDidLoad() {
        getPosts()
    }
    
    func viewWillAppear(animated: Bool) {
        if selectedSegmentedControl == .favorites {
            view.reloadData()
        }
    }
    
    func setSelectedSegmentedControl(selected: Int) {
        guard let safeSelectedSegmentedControl = SegmentedControlItems(rawValue: selected) else { return }
        selectedSegmentedControl = safeSelectedSegmentedControl
        view.reloadData()
    }
    
    func getPostData(at row: Int) -> PostModel {
        switch selectedSegmentedControl {
        case .all: return PostModel(title: allPost[row].title, type: selectedSegmentedControl)
        case .favorites: return PostModel(title: favoritesPost[row].title, type: selectedSegmentedControl)
        }
    }
    
    func refreshData() {
        getPosts()
    }
    
    func didSelectItem(row: Int) {
        let post: Post
        switch selectedSegmentedControl {
        case .all: post = allPost[row]
        case .favorites: post = favoritesPost[row]
        }
        wireframe.goToDetail(post: post)
    }
    
    func deleteAll() {
        switch selectedSegmentedControl {
        case .all:
            allPost = []
        case .favorites:
            interactor.dataManager.removeAllFavorites()
        }
        view.reloadData()
    }
}
