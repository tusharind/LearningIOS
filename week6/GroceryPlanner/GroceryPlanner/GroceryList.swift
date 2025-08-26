import SwiftUI

// MARK: - Main Grocery List View
struct GroceryList: View {
    @ObservedObject var viewModel: GroceryListVM
    @State private var isAddingItem = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.1), Color.green.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                GroceryItemsList(viewModel: viewModel)
            }
            .navigationTitle("My Grocery List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .tint(.orange)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingItem = true
                    } label: {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .tint(.orange)
                    }
                }
            }
            .sheet(isPresented: $isAddingItem) {
                AddGroceryView(viewModel: viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .accentColor(.blue)
    }
}

// MARK: - Grocery Items List
struct GroceryItemsList: View {
    @ObservedObject var viewModel: GroceryListVM
    
    var body: some View {
        List {
            ForEach($viewModel.items) { $item in
                GroceryCard(item: $item)
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 4)
                    .buttonStyle(PlainButtonStyle())
            }
            .onDelete(perform: viewModel.deleteItem)
            .onMove(perform: viewModel.moveItem)
            .buttonStyle(PlainButtonStyle())
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden) // keep gradient visible
    }
}

struct GroceryCard: View {
    @Binding var item: GroceryItem
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.7))
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            NavigationLink(destination: GroceryDetailView(item: $item)) {
                GroceryRow(item: $item)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .buttonStyle(PlainButtonStyle())
            }
            .buttonStyle(PlainButtonStyle()) // hides arrow
        }
    }
}
