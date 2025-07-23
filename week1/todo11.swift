Wednesday, July 16




//TODO 11: Add Getter and Setter Properties


struct BankAccount {
    private var balance: Double
    var availableBalance: Double {
        get {
            return balance * 1.01
        }
        set {
            balance = newValue / 1.01  //newValue is an implicit swift keyword for the set block values
        }
    }
    init(balance: Double) {
        self.balance = balance
    }
}







