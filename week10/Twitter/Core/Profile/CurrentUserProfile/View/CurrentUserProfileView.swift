import SwiftUI

struct CurrentUserProfileView: View {
    @StateObject var viewModel = CurrentUserProfileViewModel()
    @State private var showEditProfile = false

    private var currentUser: User? {
        Task { try await UserService.shared.fetchCurrentUser() }
        return viewModel.currentUser
    }
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                //bio and stats
                VStack(spacing: 20) {

                    ProfileHeaderView(user: currentUser)

                    Button {
                        showEditProfile.toggle()
                    } label: {
                        Text("Edit Profile")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 352, height: 32)
                            .background(.white)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray6), lineWidth: 1)
                            )
                    }
                    if let user = currentUser {
                        UserContentListView(user: user)
                    }

                }
            }
            .sheet(
                isPresented: $showEditProfile,
                content: {
                    if let user = currentUser {
                        EditProfileView(user: user)
                    }

                }
            )
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Text("Sign Out")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)  // text color
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.black)  // button background
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CurrentUserProfileView()
}
