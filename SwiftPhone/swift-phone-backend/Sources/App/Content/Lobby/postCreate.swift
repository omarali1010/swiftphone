//
//  File.swift
//  
//
//  Created by David Velke on 16.06.22.
//

import Foundation

struct RequestCreate: Codable {
    let name: String
    let gameSettings: GameSettings
}

struct ResponseCreate: Codable {
    let user: User
    let key: String
}
