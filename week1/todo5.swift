//To-Do 5:
//Use a switch statement with multiple patterns
//Create a function that categorizes a number based on //different ranges

func positiveOrNegative(_ num: Int) {
    switch num{
    case 1...:  //this means range from 1 to positive infinity
        print("Positive number")
    case ..<0:
        print("Negative number")  ///this means range from 0 to negative infinity
    case 0:
        print("Zero")
    default:
        print("Unhandled case")
    }
}

positiveOrNegative(10)
positiveOrNegative(0)
positiveOrNegative(-10)
