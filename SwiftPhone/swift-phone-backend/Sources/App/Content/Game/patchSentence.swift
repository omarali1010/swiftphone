//
//  File.swift
//  
//
//  Created by David Velke on 22.06.22.
//

import Foundation

struct RequestSentence:Codable {
    let key:String
    let user:User
    var sentence: String
    var ready:Bool = false
}

struct ResponseSentence:Codable {
    let sentence: String
}
