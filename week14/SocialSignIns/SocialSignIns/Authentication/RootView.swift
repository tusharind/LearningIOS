import SwiftUI
import FirebaseCore

struct RootView: View {
    @State private var showSignInView: Bool = false
    @State private var userEmail: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack(spacing: 30) {
                    if !userEmail.isEmpty {
                        Text("Welcome, \(userEmail)")
                            .font(.title2.bold())
                            .padding(.top, 40)
                    }
                    
                    SettingsView(showSignInView: $showSignInView)
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                if let authUser = try? AuthenticationManager.shared.getAuthenticatedUser() {
                    userEmail = authUser.email ?? "User"
                    showSignInView = false
                } else {
                    showSignInView = true
                }
            }
            .fullScreenCover(isPresented: $showSignInView) {
                LogInView()
            }
        }
    }
}

#Preview {
    RootView()
}
