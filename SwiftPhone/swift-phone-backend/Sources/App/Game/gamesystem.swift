//
//  gamesystem.swift
//  
//
//  Created by David Velke on 12.06.22.
//

import Foundation



let exampleSentences:[String] = [
    "Fetter Biber überquert eine Brücke",
    "Die rote Katze fängt einen Fisch",
    "Giftige Schlange in der Wüste",
    "Magischer Elf auf dem Friedhof",
    "Lächelnde Giraffe pfeift",
    "Patriotischer Maler in der Schule",
    "Detektiv mit einer Lupe",
    "Junge, der von einem Burger träumt",
    "Schlaues Mädchen im Theater",
    "Koala erklimmt einen Berg"
]

class GameSystem {
    
    static var gamesRunning:[GameSystem] = []
    let lobby:Lobby
    let gamesettings: GameSettings
    
    var round:Int = 0
    var playerCount:Int = 0
    var sentences:[String: [String]] = [:]
    var images:[String: [String]] = [:]
    var ready:[String: Bool] = [:]
    var solution:[History] = []
    
    
    
    init(lobby:Lobby, gameSettings: GameSettings) {
        self.gamesettings = gameSettings
        self.lobby = lobby
    }
    
    init(lobby:Lobby) {
        self.gamesettings = GameSettings(writetime: 60, drawtime: 60)
        self.lobby = lobby
    }
    
    private func initGame(){
        var copySentences = exampleSentences
        
        self.lobby.connections.forEach{connection in
            if let index = copySentences.indices.randomElement() {
                let value = copySentences.remove(at: index)
                let id = connection.user.id
                self.sentences[id] = [value]
                self.images[id] = []
                self.ready[id] = false
            }
        }
        self.playerCount = self.lobby.connections.count
    }
    
    private func resetStatus(){
        var ready:Dictionary<String,Bool> = [:]
        self.ready.forEach { r in
            ready[r.key] = false
        }
        self.ready = ready
    }
    
    func getSentence(id:String) -> String? {
        if let sentenceUser:[String] = self.sentences[id] {
            return sentenceUser[self.round]
        }
        return nil
    }
    
    func getImage(id:String) -> String? {
        if let imageUser:[String] = self.images[id] {
            return imageUser[self.round-1]
        }
        return nil
    }
    
    func updateStatus(id:String, status:Bool){
        self.ready[id] = status
    }
    
    func updateSentence(id:String, sentence:String){
    print(  sentence)
        self.sentences[id]?[self.round] = sentence
    }
    
    
    public func updateImage(id:String, image:String){
        self.images[id]?[self.round-1] = image
    }
    
    func appendSentence(){
        Array(self.sentences.keys).sorted().forEach({
            sentences[$0]?.append("")
        })
    }
    func appendImage(){
        Array(self.images.keys).sorted().forEach({
            self.images[$0]?.append(whiteImage)
        })
    }
    
    private func eventGather(_ time:Float){
        var timer:Int = 0
        while true {
            let isClosed = self.lobby.connections.filter({!$0.websocket.isClosed}).count
            let isReady =  self.ready.filter({$0.value}).count
            
            if(isClosed == isReady){
                break;
            }
            
            timer = timer + 1
            sleep(1)
        }
    }
    
    private func getUserName(id:String) -> String? {
        return self.lobby.connections.filter({$0.user.id == id}).first?.user.name
    }
    
    
    // Todo eventShiftSentence und eventShiftImages in einer Funktion abbilden
    //    private func eventReshiftSentence(i:Int, item:[String : [String]]) -> [String : [String]]{
    //        var copyItem = item
    //        let keys = Array(item.keys).sorted()
    //
    //        guard let firstsentence = copyItem[keys[0]]?[i] else {
    //            return copyItem
    //        }
    //
    //        for index in 0..<keys.count-1 {
    //            copyItem[keys[index]]![i] = copyItem[keys[index + 1]]![i]
    //        }
    //
    //        if(copyItem[keys[keys.count-1]] != nil ){
    //            copyItem[keys[keys.count-1]]![i] = firstsentence
    //        }
    //        return copyItem
    //    }
    
    
    private func eventShiftSentence(){
        let keys = Array(sentences.keys).sorted()
        let firstsentence:String? = self.sentences[keys[keys.count-1]]?[self.round]
        
        for index in 0..<keys.indices.count-1 {
            if let sentence = self.sentences[keys[index]] {
                self.sentences[keys[index + 1]]?.append(sentence[self.round])
            }
        }
        
        if let sen = firstsentence {
            self.sentences[keys[0]]?.append(sen)
        }
    }
    
    private func eventShiftImages(){
        let keys = Array(images.keys).sorted()
        let firstimage:String? = self.images[keys[keys.count-1]]?[self.round-1]
        
        for index in 0..<keys.indices.count-1 {
            if let image = self.images[keys[index]] {
                self.images[keys[index + 1]]?.append(image[self.round-1])
            }
        }
        
        if let img = firstimage {
            self.images[keys[0]]?.append(img)
        }
    }
    
    private func createSolutionData(items:[String: [String]]) ->[[(id: String, value: String)]]{
        let keys = Array(items.keys).sorted()
        var ret: [[(id: String, value: String)]] = []
        
        for index in keys.indices {
            var tupples:[(id: String, value: String)] = []
            let height = keys.count
            guard let width = items[keys[index]]?.count else {return ret}
            
            let help = height + index
            var j = 0
            for i in stride(from: index, to: help, by: 2){
                if(j >= Int((Double(width)/2).rounded())){
                    break
                }
                
                let helpIndex = i % height
                let val = items[keys[helpIndex]]![j*2]
                let tupple = (keys[helpIndex], val)
                tupples.append(tupple)
                j += 1
                
            }
            ret.append(tupples)
        }
        
        return ret
    }
    
    private func createSentenceSolution() -> [[Sentence]] {
        var ret:[[Sentence]] = []
        
        createSolutionData(items: self.sentences).forEach({sentences in
            var retSentences:[Sentence] = []
            sentences.forEach({
                if let username = getUserName(id: $0.id) {
                    let sentence = Sentence(name: username, sentence: $0.value)
                    retSentences.append(sentence)
                }
            })
            ret.append(retSentences)
        })
        return ret
    }
    
    private func createImageSolution() -> [[Img]] {
        var ret:[[Img]] = []
        var helpVar = createSolutionData(items: self.images)
        helpVar.append(helpVar.remove(at: 0))
        
        helpVar.forEach({images in
            var retImages:[Img] = []
            images.forEach({
                if let username = getUserName(id: $0.id) {
                    let img = Img(name: username, image: $0.value)
                    retImages.append(img)
                }
            })
            ret.append(retImages)
        })
        return ret
    }
    
    
    func eventSolution(){
        let sentences = createSentenceSolution()
        let images = createImageSolution()
        var solution:[History] = []
        
        for i in 0..<sentences.count {
            let history:History = History(sentence: sentences[i], image: images[i])
            solution.append(history)
        }
        self.solution = solution
    }
    
    // Todo Delete
    func printDebugImage(){
        Array(self.images.keys).sorted().forEach({ i in
            print("[\(i): ", terminator: "")
            self.images[i]?.forEach({ j in
                print("\(j.count),", terminator: "")
                
            })
            print("]\n", terminator: "")
        })
    }
    
    // Todo Delete
    func printDebugSentence(){
        Array(self.sentences.keys).sorted().forEach({ i in
            print("[\(i): ", terminator: "")
            self.sentences[i]?.forEach({ j in
                print("\(j),", terminator: "")
                
            })
            print("]\n", terminator: "")
        })
    }
    
    func start(){
        
        let thread:Thread = Thread(){
            self.initGame()
            self.lobby.broadcast(webSocketEvent: .eventInitSentence)
            
            
            
            while true {
                
                self.resetStatus()
                self.eventGather(self.gamesettings.writetime)
                
//                self.printDebugImage()
//                self.printDebugSentence()
                
                // Ungerade Spieler Zahl
                if(self.playerCount % 2 == 1 && self.round == self.playerCount-1){
                    break;
                }
                
                self.appendImage()
                
                
                
                self.eventShiftSentence()
                
//                self.printDebugImage()
//                self.printDebugSentence()
                
                self.round += 1
                
                self.lobby.broadcast(webSocketEvent: .eventImage)
                
                
                self.resetStatus()
                self.eventGather(self.gamesettings.drawtime)
                
                // Gerade Spieler Zahl
                if(self.playerCount % 2 == 0 && self.round == self.playerCount-1){
                    break;
                }
                self.appendSentence()
                
                
                self.eventShiftImages()
                self.round += 1
                self.lobby.broadcast(webSocketEvent: .eventDescriptionSentence)
                
            }
//            self.printDebugImage()
//            self.printDebugSentence()
            
            self.eventSolution()
            self.lobby.broadcast(webSocketEvent: .eventSolution)
        }
        
        thread.start()
        
    }
    
    
    public static func getGameSystem(key:String) -> GameSystem? {
        return self.gamesRunning.filter{($0.lobby.key == key)}.first
    }
    
    //
    ////    deinit{
    ////        self.lobby.connections.map({$0.websocket}).forEach({$0.close(promise: nil)})
    ////    }
}
