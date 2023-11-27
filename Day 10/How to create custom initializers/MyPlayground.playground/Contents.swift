import Cocoa

struct Player {
    let name: String
    let number: Int
}

var player = Player(name: "Megan R1", number: 15)
print(player)

struct Player2 {
    let name: String
    let number: Int
    
    init(name: String) {
        self.name = name
        self.number = Int.random(in: 1...99)
    }
    
    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

var player2 = Player2(name: "Megan R2")
print(player2)

var player3 = Player2(name: "Megan R3", number: 111)
print(player3)
