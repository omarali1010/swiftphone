import Vapor



func webSocket(_ app: Application) throws {
    
    app.webSocket("game") { req, ws in
        
        if(req.headers["id"].count != 1 && req.headers["key"].count != 1){
            // Todo maybe send error message
            ws.close(promise: nil)
            //            ws.close(code: .unacceptableData)
            return
        }
        
        let id = req.headers["id"][0]
        let key = req.headers["key"][0]
        
        
        guard let lobby = Lobby.getLobby(key: key) else {
            print("Connection close: Id \(id) try to connect lobby with key \(key)")
            ws.close(promise: nil)
            return
        }
        
        
        guard let user: User = lobby.getUser(id: id) else {
            ws.close(promise: nil)
            return
        }
        let connection = Connection(user: user, websocket: ws)
        lobby.connectLobby(connection: connection)
        
        ws.onText { ws, text in
            print(text)
            ws.send(text)
        }
        
        
        ws.onClose.whenComplete { result in
            switch(result){
            case .success():
                lobby.disconnectLobby(key: key, id: id)
                break
            case .failure(let error):
                lobby.disconnectLobby(key: key, id: id)
                print(error)
            }
        }
        
   
        
        
        
    }
    
    
}
//}

