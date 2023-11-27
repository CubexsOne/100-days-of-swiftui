import Cocoa

struct Employee {
    let name: String
    var vacation: Int
}

var archer = Employee(name: "Sterling Archer", vacation: 14)
archer.vacation -= 5
print(archer.vacation)
archer.vacation -= 3
print(archer.vacation)

struct Employee2 {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer2 = Employee2(name: "Sterling Archer", vacationAllocated: 14)
archer2.vacationTaken += 4
print(archer2.vacationRemaining)
archer2.vacationRemaining = 5
print(archer2.vacationAllocated)
