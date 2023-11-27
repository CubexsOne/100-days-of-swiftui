import Cocoa

/*func calculateSquareRoot(of number: Int) -> Double {
    var errorTolerance = 0.0001
    var estimate = 1.0
    var approximation = Double(number)

    while abs(estimate - approximation / estimate) > errorTolerance {
        estimate = (estimate + approximation / estimate) / 2.0
    }

    return estimate
}*/

enum NumberError: Error {
    case outOfBounds, noRoot
}

func calculateSquareRoot(of number: Int) -> Int {
    for currNumber in 1...100 {
        if currNumber * currNumber == number {
            return currNumber
        }
    }
    return 0
}

func squareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10_000 { throw NumberError.outOfBounds }
    let result = calculateSquareRoot(of: number)
    if result == 0 { throw NumberError.noRoot }
    
    return result
}

do {
    let number = 10000
    let result = try squareRoot(of: number)
    print("The square root of \(number) is \(result)")
} catch NumberError.outOfBounds {
    print("You can only use numbers in range of 1 through 10.000.")
} catch NumberError.noRoot {
    print("No root found.")
} catch {
    print("Unknown Error appears: \(error.localizedDescription)")
}
