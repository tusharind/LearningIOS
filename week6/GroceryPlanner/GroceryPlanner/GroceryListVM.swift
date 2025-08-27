import SwiftUI

class GroceryListVM: ObservableObject {
    @Published var items: [GroceryItem] = []
    
    init() {
        loadSampleItems()
    }
    
    // MARK: - Sample Data
    private func loadSampleItems() {
        items = [
            GroceryItem(name: "Apple"),
            GroceryItem(name: "Banana"),
            GroceryItem(name: "Carrot"),
            GroceryItem(name: "Broccoli"),
            GroceryItem(name: "Milk"),
            GroceryItem(name: "Cheese"),
            GroceryItem(name: "Chips"),
            GroceryItem(name: "Cookies")
        ]
    }
    
    // MARK: - CRUD Operations
    func addItem(name: String) {
        let newItem = GroceryItem(name: name)
        items.append(newItem)
    }
    
    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
}

