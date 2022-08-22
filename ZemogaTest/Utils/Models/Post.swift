//
//  Post.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case body
        case id
        case title
        case userId
    }
}
