import SwiftUI

struct GroceryDetailView: View {
    @Binding var item: GroceryItem
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.1), Color.green.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Transparent form
            Form {
                Section(header: Text("Item Info").font(.headline)) {
                    itemNameField
                    boughtToggle
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Edit Item")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Components
    private var itemNameField: some View {
        TextField("Item name", text: $item.name)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
    
    private var boughtToggle: some View {
        Toggle(isOn: $item.bought) {
            Text("Bought")
                .font(.body)
                .foregroundColor(.primary)
        }
        .toggleStyle(SwitchToggleStyle(tint: .green))
    }
}

