import SwiftUI

@MainActor
final class UsersListViewModel: ObservableObject {
    
    @Published var users: [AppUser] = []
    @Published var isLoading: Bool = false
    
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            users = try await FirestoreManager.shared.fetchAllUsers()
        } catch {
            print("Failed to fetch users:", error)
        }
    }
}
