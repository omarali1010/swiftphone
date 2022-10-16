//
//  File.swift
//  
//
//  Created by David Velke on 24.06.22.
//

import Foundation

struct Img :Codable {
    let name:String
    let image:String
}

struct RequestImage: Codable {
    let key:String
    let user: User
    let image: String
    let ready:Bool
}

struct ResponseImage: Codable {
    let image:String
}
