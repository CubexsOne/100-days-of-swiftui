import Cocoa

let surname: String = "Lasso"
var score: Double = 0

let playerName: String = "Roy"
let luckyNumber: Int = 13
let pi: Double = 3.141
let isAuthenticated: Bool = true

let albums: [String] = ["Red", "Fearless"]
var user: [String: String] = ["id": "@twostraws"]
var books: Set<String> = Set([
    "The Bluest Eye",
    "Foundation",
    "Girl, Woman, Other"
])

var soda: [String] = ["Coke", "Pepsi", "Irn-Bru"]
var teams: [String] = [String]()
var cities: [String] = []
var clues = [String]()

enum UIStyle {
    case light, dark, system
}

// var style = UIStyle.light
// var style: UIStyle = UIStyle.light
var style: UIStyle
style = .dark

let username: String
// lots of complex logic
username = "@twostraws"
// username = "taylorswift13"
// lots more complex logic
print(username)
