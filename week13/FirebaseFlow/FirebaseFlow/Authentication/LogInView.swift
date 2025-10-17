import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LogInView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {

                Spacer()

                VStack(spacing: 16) {
                    Text("Welcome to my App")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)

                    Text("Sign in to continue")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                VStack(spacing: 20) {
                    NavigationLink {
                        SignInWithEmail()
                    } label: {
                        Text("Sign In with Email")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.pink)
                            .cornerRadius(12)
                            .shadow(radius: 3)
                    }

                    GoogleSignInButton(
                        viewModel: GoogleSignInButtonViewModel(
                            scheme: .dark,
                            style: .wide,
                            state: .normal
                        )
                    ) {
                        Task {
                            do {
                                let user = try await viewModel.signInGoogle()
                                print("Signed in as \(user.email ?? "Unknown")")
                                navigateToHome = true
                            } catch {
                                print("Google sign-in failed:", error.localizedDescription)
                            }
                        }
                    }
                    .frame(height: 55)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                }
                .padding(.horizontal)

                Spacer()

                Text("By signing in, you agree to our Terms & Conditions")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                // Hidden NavigationLink for Google Sign-In
                NavigationLink("", destination: RootView(), isActive: $navigateToHome)
                    .hidden()
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}

