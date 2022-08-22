//
//  PostsInterfaces.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

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
    func goToDetail()
}

protocol PostsViewInterface: ViewInterface {
    func reloadData()
}

protocol PostsPresenterInterface: PresenterInterface {
    var numberOfItems: Int { get }
    func setSelectedSegmentedControl(selected: Int)
    func getPostData(at row: Int) -> Post
    func refreshData()
}

protocol PostsInteractorInterface: InteractorInterface { 
    func requestGetPost(completionHandler: @escaping (PostsResult) -> Void)
}
