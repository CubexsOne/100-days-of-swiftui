import Cocoa

struct BankAccount {
    var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)

let success = account.withdraw(amount: 200)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

account.funds -= 1000


struct BankAccount2 {
    private var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account2 = BankAccount2()
account.deposit(amount: 100)

let success2 = account2.withdraw(amount: 200)

if success2 {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}

struct BankAccount3 {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if funds > amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account3 = BankAccount3()
account3.deposit(amount: 100)

let success3 = account3.withdraw(amount: 50)

if success3 {
    print("Withdrew money successfully, you got: \(account3.funds)")
} else {
    print("Failed to get the money")
}
