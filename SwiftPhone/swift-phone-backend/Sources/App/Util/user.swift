import Foundation

struct User: Codable, Hashable {
    let name: String
    var id: String = UUID().uuidString
} 
