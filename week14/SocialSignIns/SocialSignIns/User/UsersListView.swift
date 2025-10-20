import SwiftUI

struct UsersListView: View {
    @StateObject private var viewModel = UsersListViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching Users...")
                    .padding()
            } else if viewModel.users.isEmpty {
                Text("No users found.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.users) { user in
                    UserRow(user: user)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("All Users")
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview {
    NavigationStack {
        UsersListView()
    }
}
