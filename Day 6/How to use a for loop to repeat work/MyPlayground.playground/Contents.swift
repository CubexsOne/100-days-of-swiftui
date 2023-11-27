import Cocoa

let platforms = ["iOS", "macOS", "tvOS", "watchOS"]
print(platforms[0...])

for os in platforms {
    print("Swift works great on \(os)")
}

for i in 1...12 {
    print("// 5 x \(i) is \(5 * i)")
}

for i in 1...12 {
    print("The \(i) times table")
    for j in 1...12 {
        print("    \(i) x \(j) is \(i * j)")
    }
    
    print()
}

for i in 1...5 {
    print("Counting from 1 through 5: \(i)")
}

for i in 1..<5 {
    print("Counting from 1 up to 5: \(i)")
}

var lyric = "Haters gonna"

for _ in 1...5 {
    lyric += " hate"
}

print(lyric)
