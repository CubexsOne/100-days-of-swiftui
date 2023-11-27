import Cocoa

func greetUser() {
    print("Hi there!")
}

greetUser()
var greetCopy = greetUser
greetCopy()

let sayHello = {
    print("Hi there!")
}

sayHello()


let sayHello2 = { (name: String) -> String in
    "Hi \(name)!"
}

print(sayHello2("Johannes"))

func greetUser2() {
    print("Hi there!")
}

greetUser2()
var greetCopy2: () -> Void = greetUser2


func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)

let sayHello3 = { (name: String) -> String in
    "Hi \(name)!"
}

sayHello3("Taylor")

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }
    
    return name1 < name2
}
// let captainFirstTeam = team.sorted(by: captainFirstSorted)
// print(captainFirstTeam)

let captainFirstTeam = team.sorted(by: { (a: String, b: String) -> Bool in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
})

print(captainFirstTeam)

let add = { (a: Int, b: Int) -> Int in
  a + b
}

print(add(5, 7))
