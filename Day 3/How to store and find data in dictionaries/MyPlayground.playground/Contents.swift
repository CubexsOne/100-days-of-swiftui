import Cocoa

var employee = ["Taylor Swift", "Singer", "Nashville"]

print("Name: \(employee[0])")
// employee.remove(at: 1)
print("Job title: \(employee[1])")
print("Location: \(employee[2])")

let employee2 = [
    "name": "Tylor Swift",
    "job": "Singer",
    "location": "Nashville",
]

print("Name: \(employee2["name", default: "Unknown"])")
print("Job title: \(employee2["singer", default: "Unknown"])")
print("Location: \(employee2["location", default: "Unknown"])")

let hasGraduated = [
    "Eric": false,
    "Maeve": true,
    "Otis": false
]

let olympics = [
    2012: "London",
    2016: "Rio de Janero",
    2021: "Tokyo"
]

print(olympics[2012, default: "Unknown"])

var heights = [String: Int]()
heights["Yao Ming"] = 229
heights["Shaquille O'Neal"] = 216
heights["LeBron James"] = 206

var archEnemies = [String: String]()
// var archEnemies = Dictionary<String, String>()
archEnemies["Batman"] = "The Joker"
archEnemies["Superman"] = "Lex Luthor"
archEnemies["Batman"] = "Penguin"
archEnemies.removeValue(forKey: "Batman")
