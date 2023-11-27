import Cocoa

var beatles = ["John", "Paul", "George", "Ringo"]
beatles.append("Adrian")
beatles.append("Allen")
beatles.append("Adrian")
beatles.append("Novall")
beatles.append("Vivian")
print(beatles[0])

var numbers = [4, 8, 15, 16, 23, 42]
print(numbers[1])

var temperatures = [25.3, 28.2, 26.4]
// temperatures.append("Chris") //
print(temperatures[2])

var scores = Array<Int>()
scores.append(100)
scores.append(80)
scores.append(85)
print(scores[1])

var albums = Array<String>();
// var albums = [String]();
// var albums = ["Folklore"];
albums.append("Folklore")
albums.append("Fearless")
albums.append("Red")
print(albums.count)

var charactes = ["Lana", "Pam", "Ray", "Sterling"]
print(charactes.count)
charactes.remove(at: 2)
print(charactes.count)

charactes.removeAll()
print(charactes.count)

let bondMovies = ["Casino Royale", "Spectre", "No Time to Die"]
print(bondMovies.contains("Frozen"))

let cities = ["London", "Tokyo", "Rome", "Budapest"]
print(cities.sorted())

let presidents = ["Bush", "Obama", "Trump", "Biden"]
let reversedPresidents = presidents.reversed()
print(reversedPresidents)
