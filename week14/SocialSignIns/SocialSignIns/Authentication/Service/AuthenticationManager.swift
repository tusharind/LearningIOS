import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import Foundation
import UIKit

// MARK: - Auth Data Model
struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

// MARK: - Authentication Manager
final class AuthenticationManager {

    static let shared = AuthenticationManager()
    private init() {}

    // MARK: - User Info
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }

    // MARK: - Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func delete() async throws {
            guard let user = Auth.auth().currentUser else {
                throw URLError(.badServerResponse)
            }
            try await user.delete()
        }
}

// MARK: - Email/Password Auth
extension AuthenticationManager {

    @discardableResult
    func createUser(email: String, password: String) async throws
        -> AuthDataResultModel
    {
        let result = try await Auth.auth().createUser(
            withEmail: email,
            password: password
        )
        return AuthDataResultModel(user: result.user)
    }

    @discardableResult
    func signInUser(email: String, password: String) async throws
        -> AuthDataResultModel
    {
        let result = try await Auth.auth().signIn(
            withEmail: email,
            password: password
        )
        return AuthDataResultModel(user: result.user)
    }
}

// MARK: - Google Sign-In
extension AuthenticationManager {

    @discardableResult
    func signInWithGoogle(credential: AuthCredential) async throws
        -> AuthDataResultModel
    {
        let result = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: result.user)
    }
}
//requestUser.auth.uid


