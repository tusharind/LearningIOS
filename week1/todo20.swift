//TODO 20: Use defer to execute cleanup cod
// Demonstrates use of defer for cleanup


func makeTea() {
    print("Boiling water...")
    
    defer {
        print("Washing the cup.")
    }
    
    print(" Boiling the tea...")
    print("Drinking tea.")
}

makeTea()
