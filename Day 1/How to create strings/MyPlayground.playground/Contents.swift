import Cocoa

let actor = "Denzel Washington"
let filename = "paris.jpg"
let result = "⭐️ You win! ⭐️"

let quote = "Then he tapped a sign saying \"Believe\" and walked away."

// How to Multiline Strings:

// WRONG
// let movie = "A day in
//   the life of an
//   Apple engineer"

// CORRECT
let movie = """
A day in
the life of an
Apple Engineer
"""

// Länge eines Strings
let nameLength = actor.count
print(nameLength)

print(result.uppercased())

print(movie.hasPrefix("A day"))
print(filename.hasSuffix(".jpg"))
