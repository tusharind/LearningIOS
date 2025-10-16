import SwiftUI

// RegistrationView
struct RegistrationView: View {
    @StateObject var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss

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
                    TextField("Full Name", text: $viewModel.fullName)
                        .customTextFieldStyle()

                    TextField("Username", text: $viewModel.username)
                        .autocapitalization(.none)
                        .customTextFieldStyle()

                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .customTextFieldStyle()

                    SecureField("Password", text: $viewModel.password)
                        .customTextFieldStyle()
                }
                .padding(.horizontal, 28)
                .padding(.top, 24)

                // Sign Up Button
                Button {
                    Task { try await viewModel.createUser() }
                } label: {
                    Text("Sign Up")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 352, height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.top, 24)

                Spacer()

                Divider()
                    .padding(.horizontal, 28)

                // Back to Login
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Already have an account?")
                        Text("Login")
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
    RegistrationView()
}
