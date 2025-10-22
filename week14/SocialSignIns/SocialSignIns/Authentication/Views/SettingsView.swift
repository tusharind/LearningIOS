import FirebaseAuth
import Foundation
import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool

    var body: some View {
        List {
            // MARK: - Account Section
            Section(
                header: Text("Account")
                    .font(.headline)
                    .foregroundColor(.gray)
            ) {

                // Log Out Button
                Button(action: {
                    Task {
                        do {
                            try viewModel.logOut()
                            showSignInView = true
                        } catch {
                            print("Log out failed:", error)
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.backward.circle.fill")
                            .foregroundColor(.red)
                        Text("Log Out")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    }
                }

                // View Users Button
                NavigationLink {
                    UsersListView()
                } label: {
                    HStack {
                        Image(systemName: "person.3.fill")
                            .foregroundColor(.blue)
                        Text("View All Users")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
            }

            Button(role: .destructive) {
                Task {
                    try await AuthenticationManager.shared.delete()
                    showSignInView = true
                }
            } label: {
                Text("Delete Account")
            }

            // MARK: - App Info Section
            Section(
                header: Text("App Info")
                    .font(.headline)
                    .foregroundColor(.gray)
            ) {
                Text("Version 1.0.0")
                Text("Firebase Demo")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}
