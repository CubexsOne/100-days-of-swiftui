import Cocoa


enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 { throw PasswordError.short }
    if password == "12345" { throw PasswordError.obvious }
    
    if password.count < 8 {
        return "Ok"
    } else if password.count < 10 {
        return "Good"
    } else {
        return "Excellent"
    }
}

let string = "12345"

// mit "try!" kann man den do catch Block umgehen, riskiert dabei aber bei einem Error einen crash.
// daher sollte diese Schreibweise nur genutzt werden wenn man sich 100% sicher ist das hier kein error geworfen wird.
// let result = try! checkPassword(string)
// print("Password rating: \(result)")

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error. \(error.localizedDescription)")
}
