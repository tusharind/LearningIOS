//Todo 17   : Create custom errors and functions that can throw

enum SnacksError: Error {
    case notAvailable
    case tooExpensive
}

func getSnack(named name: String, coins: Int) throws -> String {
    let snacks = ["cookie": 2, "juice": 3]
    
    guard let price = snacks[name] else {
        throw SnacksError.notAvailable
    }
    
    if coins < price {
        throw SnacksError.tooExpensive
    }
    
    return "You got a \(name). Nice choice."
}

do {
    let result = try getSnack(named: "cookie", coins: 1)
    print(result)
} catch SnacksError.notAvailable {
    print("Snacks khatam ho gaye.")
} catch SnacksError.tooExpensive {
    print("You need more coins.")
} catch {
    print("Something weird happened.")
}


