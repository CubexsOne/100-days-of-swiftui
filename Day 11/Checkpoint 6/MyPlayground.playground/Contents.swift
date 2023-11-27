import Cocoa

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear: Int = 0
    
    mutating func shiftUp() {
        switch currentGear + 1 {
        case 0...10:
            currentGear += 1
            print("// Du fährst nun im \(currentGear). Gang")
        default:
            print("// Du kannst nicht höher Schalten!")
        }
    }
    
    mutating func shiftDown() {
        switch currentGear - 1 {
        case 0...10:
            currentGear -= 1
            print("// Du fährst nun im \(currentGear). Gang")
        default:
            print("// Du kannst nicht niedriger Schalten!")
        }
    }
}

var car = Car(model: "Van", numberOfSeats: 7)
print("// \(car)")
car.shiftDown()
car.shiftUp()
car.shiftUp()
car.shiftUp()
print("// \(car)")
