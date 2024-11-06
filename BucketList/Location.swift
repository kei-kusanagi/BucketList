//
//  Location.swift
//  BucketList
//
//  Created by Juan Carlos Robledo Morales on 06/11/24.
//

import Foundation


struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
