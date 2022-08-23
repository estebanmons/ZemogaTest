//
//  PostsInterfaces.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

struct PostModel {
    let title: String
    let type: SegmentedControlItems
}

enum PostsResult {
    case success([Post])
    case error
}

enum SegmentedControlItems: Int, CaseIterable {
    case all
    case favorites
    
    var title: String {
        switch self {
        case .all: return "All"
        case .favorites: return "Favorites"
        }
    }
}

protocol PostsWireframeInterface: WireframeInterface {
    func goToDetail(post: Post)
}

protocol PostsViewInterface: ViewInterface {
    func reloadData()
}

protocol PostsPresenterInterface: PresenterInterface {
    var favoritesPost: [Post] { get }
    var numberOfItems: Int { get }
    func setSelectedSegmentedControl(selected: Int)
    func getPostData(at row: Int) -> PostModel
    func refreshData()
    func didSelectItem(row: Int)
}

protocol PostsInteractorInterface: InteractorInterface {
    var dataManager: DataManager { get }
    func requestGetPost(completionHandler: @escaping (PostsResult) -> Void)
}
