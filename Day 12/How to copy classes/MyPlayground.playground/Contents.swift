import Cocoa

class User {
    var username = "Anonymous"
    
    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"

print(user1.username)
print(user2.username)

struct Player {
    var playername = "Anonymous"
}

var player1 = Player()
var player2 = player1
player2.playername = "Cubi"

print(player1.playername)
print(player2.playername)
