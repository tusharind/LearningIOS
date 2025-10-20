import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    @MainActor
    func createUser() async throws {
        try await AuthService.shared.createUser(
            withEmail: email,
            password: password,
            fullname: fullName,
            username: username
        )
    }
}
