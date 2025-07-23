//TODO 13: Create a Structure with Methods




struct secretFormula {
    var secretNumber: Double
    func manipulation() -> Double {
        return .pi * secretNumber
    }
    func hugeNumber() -> Double {
        return pow(secretNumber, 2.0)
    }
}
