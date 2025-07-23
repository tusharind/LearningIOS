//To-do #7


//Create a function with multiple parameters and return values
//Function should calculate statistics for an array of numbers


func findOut(_ numbers: [Int], maxValueAllowed: Int ) -> (sum: Int, average: Int)? {
    guard !numbers.isEmpty else { return nil }
    
    var sum: Int = 0
    var minVal = numbers[0]
    var maxVal = numbers[0]
    
    for num in numbers {
        sum += num
        
        
        if(sum < maxValueAllowed) {sum = maxValueAllowed}
        
        let average = sum / (numbers.count)
        print("Sum = \(sum), Avg = \(average)")
        
        return (sum, average)
    }
}
    
    
    let values = [10, 20, 5, 30]
    
    if let stats = findOut(values,maxValueAllowed: 100) {
        print("Returned → Sum: \(stats.sum), Avg: \(stats.average)")
    }
    
    




