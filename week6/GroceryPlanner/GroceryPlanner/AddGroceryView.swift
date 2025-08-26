import SwiftUI

struct AddGroceryView: View {
    @ObservedObject var viewModel: GroceryListVM
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
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
                    TextField("Item name", text: $name)
                        .padding(6)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        addItem()
                    }
                    .tint(.green)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .tint(.red)
                }
            }
            .alert("Invalid Input", isPresented: $showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Please enter a valid item name.")
            }
        }
    }
    
    // MARK: - Functions
    private func addItem() {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmed.isEmpty {
            viewModel.addItem(name: trimmed, section: "General")
            dismiss()
        } else {
            showAlert = true
        }
    }
}

