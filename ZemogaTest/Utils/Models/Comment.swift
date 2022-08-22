//
//  Comment.swift
//  ZemogaTest
//
//  Created by Esteban Monsalve on 21/08/22.
//

import Foundation

// MARK: - Comment
struct Comment: Codable {
    let body: String
    let email: String
    let id: Int
    let name: String
    let postId: Int

    enum CodingKeys: String, CodingKey {
        case body
        case email
        case id
        case name
        case postId
    }
}
