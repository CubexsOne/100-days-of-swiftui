import Cocoa

let root = sqrt(169)
print(root)

func rollDice() -> Int {
    Int.random(in: 1...6)
}

let result1 = rollDice()
print(result1)

func areLettersIdentical(string1: String, string2: String) -> Bool {
    string1.uppercased().sorted() == string2.uppercased().sorted()
}

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a*a + b*b)
}
