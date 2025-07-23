//Work with arrays and dictionaries
//Create an array of your favorite foods and a dictionary of country capitals
//Add a new item to the array and update a value in the dictionary


var myFavFood:[String] = []
myFavFood.append("kaju katli")
myFavFood.append("icecream")
myFavFood.append("laddu")
print(myFavFood)


var countryAndCapital:[String:String] = [:]
countryAndCapital["India"] = "Delhi"
countryAndCapital["Israel"] = "Tel Aviv"
countryAndCapital["Ukraine"] = "Kiev"
countryAndCapital["China"] = "Beijing"

//updating a value in dictionary
countryAndCapital["China"] = "Shanghai"


print(countryAndCapital["China"]!) //using forced unwrapping as I'm sure that the key does exist

