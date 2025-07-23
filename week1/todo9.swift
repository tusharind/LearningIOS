//To-do #9

    //Create and use closures
    //Use closures with the map function and create a closure that captures values
    
    let numbers = [1, 2, 3, 4, 5]
    
    let doubled = applyToEach(numbers) { number in
        return number * 2
    }
    
    print(doubled) // Output: [2, 4, 6, 8, 10]
    
    let nums = [1, 2, 3, 4, 5]
    
    let square = { (number: Int) -> Int in
        return number * number
    }
    
    let squared = nums.map(square)
    
    print(squared)
