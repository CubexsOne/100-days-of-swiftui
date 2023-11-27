import Cocoa

class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    
    final func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

final class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    /*func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times will spend hours arguing about whether code should be intendet using tabs or spaces")
    }*/
}

final class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

var robert = Developer(hours: 8)
var joseph = Manager(hours: 10)

robert.work()
joseph.work()

var novall = Developer(hours: 8)
novall.printSummary()
