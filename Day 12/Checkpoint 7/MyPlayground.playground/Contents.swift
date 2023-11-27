import Cocoa

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {
        print("...")
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Wooff!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Wuff!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("WOOOOFF!")
    }
}

class Cat: Animal {
    let isTame: Bool
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Meow!")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meooow!")
    }
}

class Lion: Cat {
    override func speak() {
        print("Roarr!")
    }
}

var animals = [
    Dog(),
    Dog(),
    Corgi(),
    Poodle(),
    Cat(isTame: true),
    Persian(isTame: true),
    Lion(isTame: false),
    Persian(isTame: true)
]
for animal in animals {
    animal.speak();
}
