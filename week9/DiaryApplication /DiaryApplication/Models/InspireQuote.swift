import Foundation
import SwiftUI

struct InspireQuote: Codable {
    let content: String
    let author: String
}

extension UserDefaults {
    private enum Keys { static let lastQuote = "lastQuote" }
    ///save quote in local storage
    func saveQuote(_ quote: InspireQuote) {
        if let data = try? JSONEncoder().encode(quote) {
            set(data, forKey: Keys.lastQuote)
        }
    }
    ///load quote from local storage
    func loadQuote() -> InspireQuote? {
        guard let data = data(forKey: Keys.lastQuote),
              let quote = try? JSONDecoder().decode(InspireQuote.self, from: data) else {
            return nil
        }
        return quote
    }
}





