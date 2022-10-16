//
//  routeGame.swift
//  
//
//  Created by David Velke on 21.06.22.
//

import Foundation
import Vapor

func routingGame(_ app: RoutesBuilder) throws {
    
    app.get("sentence", ":key", ":id"){ req -> String in
        guard let key = req.parameters.get("key") else {
            throw Abort(.badRequest)
        }
        
        guard let id = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }
        
        guard let gameSystem: GameSystem = GameSystem.getGameSystem(key: key) else {
            throw Abort(.notFound)
        }
        
        guard let sentence = gameSystem.getSentence(id: id) else {
            throw Abort(.notFound)
        }
                
        // Response
        guard let encoded = try? JSONEncoder().encode(ResponseSentence(sentence: sentence)) else {
            throw Abort(.internalServerError)
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            throw Abort(.internalServerError)
        }
        
        return json
    
    }
    
    app.patch("sentence"){ req -> String in
        
        if let body = req.body.data {
            let requestSentence:RequestSentence = try JSONDecoder().decode(RequestSentence.self, from: body)
            
            guard let gameSystem: GameSystem = GameSystem.getGameSystem(key: requestSentence.key) else {
                throw Abort(.notFound)
            }
            
            gameSystem.updateSentence(id: requestSentence.user.id,sentence: requestSentence.sentence)
            gameSystem.updateStatus(id: requestSentence.user.id, status: requestSentence.ready)
            
            // Response
            return ""
        }
        
        throw Abort(.badRequest)
    }
    
    
    app.get("image", ":key", ":id"){ req -> String in
        guard let key = req.parameters.get("key") else {
            throw Abort(.badRequest)
        }
        
        guard let id = req.parameters.get("id") else {
            throw Abort(.badRequest)
        }
        
        guard let gameSystem: GameSystem = GameSystem.getGameSystem(key: key) else {
            throw Abort(.notFound)
        }
        
        guard let image = gameSystem.getImage(id: id) else {
            throw Abort(.notFound)
        }
                
        // Response
        let responseImage:ResponseImage = ResponseImage(image: image)
        guard let encoded = try? JSONEncoder().encode(responseImage) else {
            throw Abort(.internalServerError)
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            throw Abort(.internalServerError)
        }
        
        return json
    
    }
    
    app.on(.PATCH, "image", body: .collect(maxSize: "1mb")) { req -> String in
        if let body = req.body.data {
            let requestImage:RequestImage = try JSONDecoder().decode(RequestImage.self, from: body)
            
            guard let gameSystem: GameSystem = GameSystem.getGameSystem(key: requestImage.key) else {
                throw Abort(.notFound)
            }
            
            gameSystem.updateImage(id: requestImage.user.id,image: requestImage.image)
            gameSystem.updateStatus(id: requestImage.user.id, status: requestImage.ready)
            
            // Response
            return ""
        }

        throw Abort(.badRequest)
    }
    
    
    
    app.get("solution", ":key"){ req -> String in
        
        guard let key = req.parameters.get("key") else {
            throw Abort(.badRequest)
        }
        guard let gameSystem: GameSystem = GameSystem.getGameSystem(key: key) else {
            throw Abort(.notFound)
        }
        
        // Response
        let solution:[History] = gameSystem.solution
        guard let encoded = try? JSONEncoder().encode(solution) else {
            throw Abort(.internalServerError)
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            throw Abort(.internalServerError)
        }
        
        return json
    }
    
}


