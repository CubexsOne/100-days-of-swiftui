import Cocoa


func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

print(getRandomNumber() == getRandomNumber());

protocol Vehicle {
    func drive()
}

struct Car: Vehicle {
    func drive() {
        print("Brumm!")
    }
    
    func park() {
        print("I'm parking!")
    }
}

func getVehicle() -> some Vehicle {
    return Car()
}

func getVehicle2() -> Vehicle {
    return Car()
}

var car = getVehicle()
car.drive()

var car2 = getVehicle2()
if let car3 = car as? Car {
    car3.park()
}
