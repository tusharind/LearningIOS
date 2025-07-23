//To-Do 4:  Implement a function that uses if-let for optional binding


func optionalBinding(_ couldBeNull: String?) {
    if let value = couldBeNull {
        print("we did not encounter a \(value)")
    } else {
        print("we did encounter a nil")
    }
}

optionalBinding( "Tushar")
optionalBinding( nil)
