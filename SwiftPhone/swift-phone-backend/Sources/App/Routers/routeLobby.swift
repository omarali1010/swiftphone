//
//  routeLobby.swift
//  
//
//  Created by David Velke on 21.06.22.
//

import Foundation
import Vapor

func routingLobby(_ app: RoutesBuilder) throws {
    app.post("create") { req -> String in
        if let body = req.body.data {
            let requestCreate: RequestCreate = try JSONDecoder().decode(RequestCreate.self, from: body)
            let user: User = User(name: requestCreate.name)
            let lobby: Lobby = Lobby(creator: user, gameSettings: requestCreate.gameSettings)
            
            // Response
            let responseCreate = ResponseCreate(user: user, key: lobby.key)
            guard let encoded = try? JSONEncoder().encode(responseCreate) else {
                throw Abort(.internalServerError)
            }
            guard let json = String(data: encoded, encoding: .utf8) else {
                throw Abort(.internalServerError)
            }
            Lobby.lobbys.append(lobby)
            return json
        }
        
        throw Abort(.badRequest)
    }
    
    app.post("join"){ req -> String in
        if let body = req.body.data {
            let requestJoin: RequestJoin = try JSONDecoder().decode(RequestJoin.self, from: body)
            let key = requestJoin.key
            let name = requestJoin.name
            
            
            print(key)
            guard let lobby = Lobby.lobbys.filter({$0.key == key}).first else {
                throw Abort(.notFound)
            }
            
            if(lobby.connections.filter({!$0.websocket.isClosed}).count >= 8){
                throw Abort(.forbidden)
            }
            
            let user = User(name: name)
            
            // Response
            let responseJoin = ResponseJoin(user: user, gameSettings: lobby.gameSettings)
            guard let encoded = try? JSONEncoder().encode(responseJoin) else {
                throw Abort(.internalServerError)
            }
            guard let json = String(data: encoded, encoding: .utf8) else {
                throw Abort(.internalServerError)
            }
            
            lobby.joinLobby(user: user)
            return json
        }
        
        
        throw Abort(.badRequest)
    }
    
    
    app.get("userlist", ":key"){ req -> String in
        
        if let key = req.parameters.get("key") {
            guard let lobby = Lobby.getLobby(key: key) else {
                throw Abort(.notFound)
            }
            
            // Response
            let responseUserlist = ResponseUserlist(users: lobby.userList())
            guard let encoded = try? JSONEncoder().encode(responseUserlist) else {
                throw Abort(.internalServerError)
            }
            guard let json = String(data: encoded, encoding: .utf8) else {
                throw Abort(.internalServerError)
            }
            
            return json
        }
        
        throw Abort(.badRequest)
    }
    
    
    app.patch("start"){ req -> String in
        
        if let body = req.body.data {
            let requestStart: RequestStart = try JSONDecoder().decode(RequestStart.self, from: body)
            
            guard let lobby = Lobby.getLobby(key: requestStart.key) else {
                throw Abort(.badRequest)
            }
            lobby.start()
            
            // Response
            return ""
        }
        
        throw Abort(.badRequest)
    }
    
    
}
