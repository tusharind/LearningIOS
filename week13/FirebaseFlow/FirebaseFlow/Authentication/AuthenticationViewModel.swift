import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth
import FirebaseFirestore

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
        let signInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        //  Retrieve tokens
        guard let idToken = signInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = signInResult.user.accessToken.tokenString
        
        //  Create Firebase credential
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        //  Sign in to Firebase
        let authResult = try await AuthenticationManager.shared.signInWithGoogle(credential: credential)
        
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
}
