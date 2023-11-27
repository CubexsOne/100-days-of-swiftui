import Cocoa

class User {
    var name = "Paul"
    
    deinit {
        print("killed \(name)")
    }
}

var user = User()
user.name = "Taylor"
print(user.name)

user = User()
print(user.name)

let user2 = User()
user2.name = "Taylor"
print(user2.name)

// user2 = User()
// print(user2.name)
