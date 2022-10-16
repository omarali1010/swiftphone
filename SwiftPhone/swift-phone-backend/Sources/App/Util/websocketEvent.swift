//
//  File.swift
//  
//
//  Created by David Velke on 18.06.22.
//

import Foundation

enum WebSocketEvent: String, CodingKey, Codable {
    case eventLobbylist
    case eventLobby
    case eventInitSentence
    case eventImage
    case eventDescriptionSentence
    case eventSolution
}
