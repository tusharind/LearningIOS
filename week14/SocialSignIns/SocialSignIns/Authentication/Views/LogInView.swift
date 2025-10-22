import AuthenticationServices
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct LogInView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {

                Spacer()

                // Welcome Section
                VStack(spacing: 12) {
                    Text("Welcome to My App")
                        .font(.system(size: 36, weight: .bold))
                        .multilineTextAlignment(.center)

                    Text("Sign in to continue")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 30)

                // MARK: - Sign-In Buttons Section
                VStack(spacing: 16) {
                    // Email
                    NavigationLink {
                        SignInWithEmail()
                    } label: {
                        Text("Sign In with Email")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color.pink.opacity(0.8), Color.pink,
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(14)
                            .shadow(
                                color: .pink.opacity(0.4),
                                radius: 6,
                                x: 0,
                                y: 4
                            )
                    }

                    // MARK: - Google
                    GoogleSignInButton(
                        viewModel: GoogleSignInButtonViewModel(
                            scheme: .dark,
                            style: .wide,
                            state: .normal
                        )
                    ) {
                        Task { @MainActor in
                            guard Utilities.shared.topViewController() != nil
                            else { return }
                            do {
                                let user = try await viewModel.signInGoogle()
                                print("Signed in as \(user.email ?? "Unknown")")
                                navigateToHome = true
                            } catch {
                                print(
                                    "Google sign-in failed:",
                                    error.localizedDescription
                                )
                            }
                        }
                    }
                    .frame(height: 55)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)

                    // MARK: - GitHub
                    SignInButton(
                        title: "Sign In with GitHub",
                        icon: "octagon.fill",
                        bgColor: Color.black,
                        shadowColor: Color.black.opacity(0.3)
                    ) {
                        Task { @MainActor in
                            guard
                                let topVC = Utilities.shared.topViewController()
                            else { return }
                            do {
                                let user = try await viewModel.signInWithGitHub(
                                    //presenting: topVC
                                )
                                print(
                                    "Signed in with GitHub as \(user.email ?? "Unknown")"
                                )
                                navigateToHome = true
                            } catch {
                                print(
                                    "GitHub sign-in failed:",
                                    error.localizedDescription
                                )
                            }
                        }
                    }

                    // MARK: - Yahoo
                    SignInButton(
                        title: "Sign In with Yahoo",
                        icon: "envelope",
                        gradient: LinearGradient(
                            colors: [Color.purple.opacity(0.8), Color.purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        shadowColor: Color.purple.opacity(0.3)
                    ) {
                        Task { @MainActor in
                            guard
                                let topVC = Utilities.shared.topViewController()
                            else { return }
                            do {
                                let user = try await viewModel.signInWithYahoo(
                                    presenting: topVC
                                )
                                print("Signed in as \(user.email ?? "Unknown")")
                                navigateToHome = true
                            } catch {
                                print(
                                    "Yahoo sign-in failed:",
                                    error.localizedDescription
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)

                Spacer()

                // Terms
                Text("By signing in, you agree to our Terms & Conditions")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)

                NavigationLink(
                    "",
                    destination: RootView(),
                    isActive: $navigateToHome
                )
                .hidden()
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}

// MARK: - Reusable Sign-In Button
struct SignInButton: View {
    var title: String
    var icon: String? = nil
    var bgColor: Color = .blue
    var gradient: LinearGradient? = nil
    var shadowColor: Color = .black.opacity(0.2)
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let icon { Image(systemName: icon).foregroundColor(.white) }
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(
                gradient
                    ?? LinearGradient(
                        colors: [bgColor, bgColor],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
            ).cornerRadius(14)
            .shadow(color: shadowColor, radius: 6, x: 0, y: 4)
        }
    }
}
