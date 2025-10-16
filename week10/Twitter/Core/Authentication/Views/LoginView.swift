import SwiftUI

// ViewModifier
struct CustomTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

//Extension for cleaner usage
extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(CustomTextFieldStyle())
    }
}

//LoginView
struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                // Logo
                Image("twitter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding()

                // Input Fields
                VStack(spacing: 16) {
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .customTextFieldStyle()

                    SecureField(
                        "Enter your password",
                        text: $viewModel.password
                    )
                    .customTextFieldStyle()
                }
                .padding(.horizontal, 28)
                .padding(.top, 24)

                // Forgot Password
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 28)
                        .padding(.top, 8)
                }

                // Login Button
                Button {
                    Task { try await viewModel.login() }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 24)

                Spacer()

                // Divider
                Divider()
                    .padding(.horizontal, 28)

                // Sign Up Link
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.blue)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

#Preview {
    LoginView()
}
