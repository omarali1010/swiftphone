//
//  routing.swift
//  
//
//  Created by David Velke on 16.06.22.
//

import Foundation
import Vapor

func routing(_ app: Application) throws {
    try routingLobby(app.grouped("lobby"))
    try routingGame(app.grouped("game")) 
   
}
