import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {

    /// Sign in with Google and store user in Firestore
    @discardableResult
    func signInGoogle() async throws -> AuthDataResultModel {
        //  Get the top view controller for presenting Google Sign-In
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }

        // Start Google Sign-In flow
        let signInResult = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: topVC
        )

        //  Retrieve tokens
        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = signInResult.user.accessToken.tokenString

        //  Create Firebase credential
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )

        //  Sign in to Firebase
        let authResult = try await AuthenticationManager.shared
            .signInWithGoogle(credential: credential)

        //  Store user data in Firestore
        let user = AppUser(
            id: authResult.uid,
            email: authResult.email,
            displayName: signInResult.user.profile?.name
        )
        try await FirestoreManager.shared.storeUser(user: user)

        //  Return signed-in user
        return authResult
    }

    // MARK: - GitHub Sign-In
    @MainActor
    func signInWithGitHub(presenting viewController: UIViewController)
        async throws -> AuthDataResultModel
    {
        let provider = OAuthProvider(providerID: "github.com")
        provider.customParameters = ["allow_signup": "false"]
        provider.scopes = ["user:email"]

        return try await withCheckedThrowingContinuation { continuation in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let credential else {
                    continuation.resume(
                        throwing: NSError(
                            domain: "GitHubAuth",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey:
                                    "No credential returned"
                            ]
                        )
                    )
                    return
                }

                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let user = result?.user else {
                        continuation.resume(
                            throwing: NSError(
                                domain: "GitHubAuth",
                                code: -2,
                                userInfo: [
                                    NSLocalizedDescriptionKey:
                                        "No user returned"
                                ]
                            )
                        )
                        return
                    }

                    continuation.resume(
                        returning: AuthDataResultModel(user: user)
                    )
                }
            }
        }
    }

    // MARK: - Yahoo Sign-In
    @MainActor
    func signInWithYahoo(presenting viewController: UIViewController)
        async throws -> User
    {
        let provider = OAuthProvider(providerID: "yahoo.com")
        provider.customParameters = [
            "prompt": "login",
            "language": "en",
        ]

        return try await withCheckedThrowingContinuation { continuation in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let credential else {
                    continuation.resume(
                        throwing: NSError(
                            domain: "YahooAuth",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: "No credential found"
                            ]
                        )
                    )
                    return
                }

                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let user = result?.user else {
                        continuation.resume(
                            throwing: NSError(
                                domain: "YahooAuth",
                                code: -2,
                                userInfo: [
                                    NSLocalizedDescriptionKey: "No user found"
                                ]
                            )
                        )
                        return
                    }

                    continuation.resume(returning: user)
                }
            }
        }
    }

}
