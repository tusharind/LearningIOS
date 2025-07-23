//Tuesday, 15 July
//To-do #6


//Use for-in loops with different collections


//Looping over a String


let company: String = "Coditas"
for iterator in company {
    print(iterator, terminator: " ") //this prints each letter on the same line with spaces
}


//Looping over a Set
let domains: Set = ["iOS", "flutter", "android", "React"]
for domain in domains { //we print each element in the set by iterating over it
    print(domain)
}


//Looping over a dictionary
let peopleAndTeams = ["Tushar": "iOS", "Shreya": "Java", "Shakshi": "Android"]
for(people,team) in peopleAndTeams{ //unpacking the key and value
    print("\(people) belongs to team \(team)")
}


//Looping over an Array
let movies = ["Masan","Tumbad","Talvar","Jab We Met"]
for movie in movies {
    print("\(movie) is my all time favourites")
}







//Create a function that processes both arrays and dictionaries


func addAllElements<T: Numeric>(_ input: Any) -> T {
    var total: T = 0
    
    if let dict = input as? [AnyHashable: T] {
        for (_, value) in dict {
            total += value
        }
    } else if let array = input as? [T] {
        for value in array {
            total += value
        }
    } else {
        print("Unsupported type")
    }
    return total
}


let array = [1, 2, 3, 4, 5]
let dict = ["a": 10, "b": 20, "c": 30]
let arraySum: Int =  addAllElements(array)
print("Array sum: \(arraySum)")
let dictSum: Int =  addAllElements(dict)
print("Dictionary sum: \(dictSum)")
