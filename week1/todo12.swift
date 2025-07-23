//TODO 12: Create an Enumeration with Methods and Associated Values


enum TravellingMethod {
    case flight(amount: Int)
    case train(name: String, time: Int)
    case car(model: String, occupancy: Int)
    func howToTravel() -> String {
        switch self {
        case .flight(let amount):
            return "The tickets will cost ₹\(amount)"
        case .train(let name, let time):
            return "The train \(name) will take \(time) minutes"
        case .car(let model, let occupancy):
            return "We will take a \(model) with room for \(occupancy) people"
        }
    }
}


