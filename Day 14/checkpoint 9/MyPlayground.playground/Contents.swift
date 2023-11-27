import Cocoa

func doSomething(arr: [Int]?) -> Int {
    arr?.randomElement() ?? Int.random(in: 1...100)
}

doSomething(arr: nil)
