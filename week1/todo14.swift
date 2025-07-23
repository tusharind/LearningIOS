//TODO 14: Create a Function That Returns an Array of Cards (Full Deck)

enum TypeOfCard: String {
    case hearts, diamonds, clubs, spades
    static var allCases: [TypeOfCard] {
        return [.hearts, .diamonds, .clubs, .spades]
    }
}
enum Number: String {
    case two = "2", three = "3", four = "4", five = "5", six = "6"
    case seven = "7", eight = "8", nine = "9", ten = "10"
    case jack = "J", queen = "Q", king = "K", ace = "A"
    static var allCases: [Number] {
        return [.two, .three, .four, .five, .six,
                .seven, .eight, .nine, .ten,
                .jack, .queen, .king, .ace]
    }
}
struct Card {
    let num: Number
    let typeOfCard: TypeOfCard
}
func createDeck() -> [Card] {
    var ans: [Card] = []
    for i in TypeOfCard.allCases {
        for j in Number.allCases {
            deck.append(Card(num: j, typeOfCard: i))
        }
    }
    return ans
}

