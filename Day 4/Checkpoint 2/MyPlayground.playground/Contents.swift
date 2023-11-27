import Cocoa

var marvelHeros = ["Iron Man", "Thor", "Captain America", "Captain Marvel", "Hawkeye", "Black Widow", "Hulk", "Wanda", "Vision", "Black Panther"]
print("We have \(marvelHeros.count) Heros in this list!")
print("We have \(Set(marvelHeros).count) unique Heros in this list!")

var itemsOnTheTopShelfOfTheFridge = ["Yoghurt", "Yoghurt", "Yoghurt", "Yoghurt", "Yoghurt", "Red Bull White Edition", "Red Bull White Edition", "Red Bull Green Edition"]
print("I have \(itemsOnTheTopShelfOfTheFridge.count) Items in the top shelf!")
print("I have \(Set(itemsOnTheTopShelfOfTheFridge).count) unique Items in the top shelf!")
