import SwiftUI

struct GroceryItem: Identifiable {
    let id = UUID()
    var name: String
    var bought: Bool = false
}

