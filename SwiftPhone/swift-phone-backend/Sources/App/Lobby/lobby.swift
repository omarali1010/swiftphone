import WebSocketKit
import Foundation

class Lobby  {
    static var lobbys:[Lobby] = []
    let maxConnections:Int = 8
    let creator: User
    var key: String!
    let gameSettings: GameSettings
    
    var users:[User] = []
    var connections:[Connection] = []
    
    
    init(creator: User, gameSettings: GameSettings) {
        self.creator = creator
        self.gameSettings = gameSettings
        
        var key:String = self.createLobbyKey()
        // Todo cancel if to much rounds
        while(Lobby.lobbys.filter({$0.key == key}).count != 0
              && GameSystem.gamesRunning.filter({$0.lobby.key != key}).count != 0)
        {
            key = self.createLobbyKey()
        }
        
        self.key = key
        self.joinLobby(user: creator)
        self.broadcast(webSocketEvent: .eventLobbylist)
        print("Create Lobby with id: \(self.key ?? "")")
    }
    
    public static func getLobby(key:String) -> Lobby? {
        return self.lobbys.filter{($0.key == key)}.first
    }
    
    public func joinLobby(user: User){
        self.users.append(user)
    }
    
    
    public func getUser(id: String) -> User? {
        return self.users.filter{$0.id == id}.first
    }
    
    private func createLobbyKey() -> String {
        let length = Range(4...8).randomElement()!
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private func updateLobbylist()  {
        self.broadcast(webSocketEvent: .eventLobbylist)
    }
    
    public func connectLobby(connection: Connection){
        self.connections.append(connection)
        self.users = self.users.filter{$0.id != connection.user.id}
        self.sendMessageToUser(user: connection.user, webSocketEvent: .eventLobby)
        self.updateLobbylist()
    }
    
    public func disconnectLobby(key:String, id:String){
        if let lobby = Lobby.getLobby(key: key){
            lobby.connections = lobby.connections.filter({$0.user.id != id })
            self.updateLobbylist()
        }
    }
    
    public func broadcast(webSocketEvent: WebSocketEvent){
        guard let encoded = try? JSONEncoder().encode(webSocketEvent) else {
            return
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            return
        }
        self.connections.forEach({$0.websocket.send(json)})
    }
    
    public func sendMessageToCreator(webSocketEvent:WebSocketEvent){
        guard let encoded = try? JSONEncoder().encode(webSocketEvent) else {
            return
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            return
        }
        self.connections.filter{$0.user.id == creator.id}.forEach{$0.websocket.send(json)}
    }
    
    public func sendMessageToUser(user:User, webSocketEvent:WebSocketEvent) {
        guard let encoded = try? JSONEncoder().encode(webSocketEvent) else {
            return
        }
        guard let json = String(data: encoded, encoding: .utf8) else {
            return
        }
        self.connections.filter{$0.user.id == user.id}.forEach{$0.websocket.send(json)}
    }
    
    public func userList() -> [String]{
        return self.connections.map({$0.user.name})
    }
    
    
    public func start() {
        let lobby = self
        Lobby.lobbys = Lobby.lobbys.filter{$0.key != self.key}
        let gamesystem:GameSystem = GameSystem(lobby: lobby, gameSettings: self.gameSettings)
        GameSystem.gamesRunning.append(gamesystem)
        gamesystem.start()
    }
}
