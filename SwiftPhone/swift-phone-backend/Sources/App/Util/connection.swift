import Vapor

struct Connection {
    let user: User
    var websocket: WebSocket
}
