import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
}

struct SignInWithEmail: View {
    
    @StateObject private var viewModel = SignInEmailViewModel()
    @State private var navigateToHome = false // <-- navigation state

    var body: some View {
        VStack(spacing: 20) {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
                .autocapitalization(.none)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        navigateToHome = true
                    } catch {
                        do {
                            try await viewModel.signIn()
                            navigateToHome = true
                        } catch {
                            print(error)
                        }
                    }
                }
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            // Hidden NavigationLink for navigation
            NavigationLink("", destination: RootView(), isActive: $navigateToHome)
                .hidden()
        }
        .padding()
        .navigationTitle("Sign In with Email")
    }
}

