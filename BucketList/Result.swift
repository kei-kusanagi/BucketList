//
//  Result.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 07/11/24.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}