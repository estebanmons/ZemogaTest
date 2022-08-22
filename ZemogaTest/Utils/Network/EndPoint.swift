//
//  EndPoint.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

enum EndPoint {
    case getPosts
    case getPostComments(id: Int)
    case getUser(id: Int)
    
    var path: String {
        switch self {
        case .getPosts:
            return baseURL + "posts"
        case .getPostComments(let id):
            return baseURL + "posts/\(id)/comments"
        case .getUser(let id):
            return baseURL + "users/\(id)"
        }
    }
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}
