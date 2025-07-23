//TODO 21: Create generic functions and types

// Generic swap function
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 42
var y = 99
swapValues(&x, &y)
print("After swap:", x, y)
