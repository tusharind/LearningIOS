import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = GroceryListVM()
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
                
                GroceryList(viewModel: viewModel)
            }
        }
        .accentColor(.blue)
    }
}

