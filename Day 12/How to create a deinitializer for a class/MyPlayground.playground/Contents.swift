import Cocoa

class User {
    let id: Int
    
    init(id: Int) {
        self.id = id
        print("// User \(id): I'm alive!")
    }

    deinit {
        print("// User \(id): I'm dead!")
    }
}

print("// Ohne Array")
for i in 1...3 {
    let user = User(id: i)
    print("// User \(user.id): I'm in control!")
}

var users = [User]()

print("// Mit Array")
for i in 1...3 {
    let user = User(id: i)
    print("// User \(user.id): I'm in control!")
    users.append(user)
}

print("// Loop is finished!")
users.removeAll()
print("// Array is clear!")
