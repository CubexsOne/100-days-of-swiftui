import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get }
    var sellingAgent: String { get }
    
    func printSummary()
}

extension Building {
    func printSummary() {
        print("The Building has \(rooms) rooms, costs \(cost)€ and is being sold by \(sellingAgent)")
    }
}

struct House: Building {
    let rooms = 8
    let cost = 1_000_000
    let sellingAgent = "Cubus Maximus"
    
    func printSummary() {
        print("The house has \(rooms) rooms, costs \(cost)€ and is being sold by \(sellingAgent)")
    }
}

struct Office: Building {
    let rooms = 16
    let cost = 2_000_000
    let sellingAgent = "Cubus Maximus"
    
    func printSummary() {
        print("The Office has \(rooms) rooms, costs \(cost)€ and is being sold by \(sellingAgent)")
    }
}

House().printSummary()
Office().printSummary()
