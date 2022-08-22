//
//  EndPoint.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

enum EndPoint {
    case posts
    
    var path: String {
        switch self {
        case .posts:
            return baseURL + "posts"
        }
    }
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}
