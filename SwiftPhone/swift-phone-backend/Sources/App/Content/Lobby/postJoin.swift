//
//  File.swift
//  
//
//  Created by David Velke on 16.06.22.
//

import Foundation

struct RequestJoin: Codable {
    let name: String
    let key: String
}

struct ResponseJoin: Codable {
    let user: User
    let gameSettings:GameSettings
}
