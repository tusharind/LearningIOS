
    //To-do #8
    //Create a function that takes another function as parameter
   //Implement a function that applies an operation to each element 


        func applyToEach(_ array: [Int], operation: (Int) -> Int) -> [Int] {
        var result: [Int] = []
        for value in array {
            result.append(operation(value))
        }
        return result
    }

