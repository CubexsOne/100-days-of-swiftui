import Cocoa

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]

let captainFirstTeam = team.sorted(by: { (a: String, b: String) -> Bool in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
})

print(captainFirstTeam)

let captainFirstTeam2 = team.sorted(by: { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
})

print(captainFirstTeam2)

let captainFirstTeam3 = team.sorted { a, b in
    if a == "Suzanne" {
        return true
    } else if b == "Suzanne" {
        return false
    }
    
    return a < b
}

print(captainFirstTeam3)

let captainFirstTeam4 = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    
    return $0 < $1
}

print(captainFirstTeam4)

let reverseTeam = team.sorted {
    return $0 > $1
}
print(reverseTeam)

let reverseTeam2 = team.sorted { $0 > $1 }
print(reverseTeam2)

let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

let teamNameLength = team.map { $0.count }
print(teamNameLength)
