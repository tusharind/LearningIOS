import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@MainActor
final class AuthenticationViewModel: ObservableObject {

    // MARK: - Google Sign-In
    @discardableResult
    func signInGoogle() async throws -> AuthDataResultModel {
        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }

        let signInResult = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: topVC
        )

        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }

        let accessToken = signInResult.user.accessToken.tokenString

        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )

        let authResult = try await AuthenticationManager.shared
            .signInWithGoogle(credential: credential)

        let user = AppUser(
            id: authResult.uid,
            email: authResult.email,
            displayName: signInResult.user.profile?.name
        )
        try await FirestoreManager.shared.storeUser(user: user)

        return authResult
    }

    // MARK: - GitHub Sign-In
    @MainActor
    func signInWithGitHub() async throws -> AuthDataResultModel {
        let provider = OAuthProvider(providerID: "github.com")
        provider.scopes = ["user:email"]

        return try await withCheckedThrowingContinuation { continuation in
            provider.getCredentialWith(nil) { credential, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let githubCredential = credential else {
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

                //Handle linking if already signed in
                if let currentUser = Auth.auth().currentUser {
                    currentUser.link(with: githubCredential) {
                        result,
                        linkError in
                        if let linkError = linkError as NSError? {
                            // If account already linked 
                            if linkError.code
                                == AuthErrorCode.credentialAlreadyInUse.rawValue
                            {
                                // Sign in with that credential instead
                                Auth.auth().signIn(with: githubCredential) {
                                    result,
                                    signInError in
                                    if let signInError = signInError {
                                        continuation.resume(
                                            throwing: signInError
                                        )
                                    } else if let user = result?.user {
                                        continuation.resume(
                                            returning: AuthDataResultModel(
                                                user: user
                                            )
                                        )
                                    }
                                }
                                return
                            }

                            continuation.resume(throwing: linkError)
                            return
                        }

                        guard let user = result?.user else {
                            continuation.resume(
                                throwing: NSError(
                                    domain: "GitHubAuth",
                                    code: -2,
                                    userInfo: [
                                        NSLocalizedDescriptionKey:
                                            "No user returned after linking"
                                    ]
                                )
                            )
                            return
                        }

                        continuation.resume(
                            returning: AuthDataResultModel(user: user)
                        )
                    }

                } else {
                    //If no one signed in, do normal GitHub sign-in
                    Auth.auth().signIn(with: githubCredential) {
                        result,
                        error in
                        if let error = error as NSError? {
                            if error.domain == AuthErrorDomain,
                                error.code
                                    == AuthErrorCode
                                    .accountExistsWithDifferentCredential
                                    .rawValue
                            {
                                self.handleExistingAccountError(
                                    error,
                                    pendingCredential: githubCredential,
                                    continuation: continuation
                                )
                                return
                            }
                            continuation.resume(throwing: error)
                            return
                        }

                        guard let user = result?.user else {
                            continuation.resume(
                                throwing: NSError(
                                    domain: "GitHubAuth",
                                    code: -3,
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
    }

    // MARK: - Handle Existing Account or New User Creation
    private func handleExistingAccountError(
        _ error: NSError,
        pendingCredential: AuthCredential,
        continuation: CheckedContinuation<AuthDataResultModel, Error>
    ) {
        guard let email = error.userInfo[AuthErrorUserInfoEmailKey] as? String
        else {
            continuation.resume(throwing: error)
            return
        }

        Auth.auth().fetchSignInMethods(forEmail: email) { methods, fetchError in
            if let fetchError = fetchError {
                continuation.resume(throwing: fetchError)
                return
            }

            //If no sign-in methods are found, just sign in directly with GitHub (new user)
            guard let firstMethod = methods?.first else {
                Task {
                    do {
                        let result = try await Auth.auth().signIn(
                            with: pendingCredential
                        )
                        continuation.resume(
                            returning: AuthDataResultModel(user: result.user)
                        )
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
                return
            }

            // Example: If existing provider is Google
            if firstMethod == "google.com" {
                Task {
                    do {
                        let googleUser = try await self.signInGoogle()
                        let currentUser = Auth.auth().currentUser
                        try await currentUser?.link(with: pendingCredential)
                        continuation.resume(returning: googleUser)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            } else {
                continuation.resume(
                    throwing: NSError(
                        domain: "GitHubAuth",
                        code: -4,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                                "Please sign in using \(firstMethod) to link GitHub."
                        ]
                    )
                )
            }
        }
    }

    // MARK: - Yahoo Sign-In
    @MainActor
    func signInWithYahoo(presenting viewController: UIViewController)
        async throws -> User
    {
        let provider = OAuthProvider(providerID: "yahoo.com")
        provider.customParameters = ["prompt": "login", "language": "en"]

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
