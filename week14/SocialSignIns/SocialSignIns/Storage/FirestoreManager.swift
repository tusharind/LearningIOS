import Foundation
import FirebaseFirestore


final class FirestoreManager {
    
    static let shared = FirestoreManager()
    private init() { }
    
    private let db = Firestore.firestore()
    
    // MARK: - Store User Data
    func storeUser(user: AppUser) async throws {
        guard let uid = user.id else { return }
        try await db.collection("Users").document(uid).setData(from: user)
    }
    
    // MARK: - Fetch Single User
    func fetchUser(uid: String) async throws -> AppUser? {
        let doc = try await db.collection("Users").document(uid).getDocument()
        return try doc.data(as: AppUser.self)
    }
    
    // MARK: - Fetch All Users
    func fetchAllUsers() async throws -> [AppUser] {
        let snapshot = try await db.collection("Users").getDocuments()
        return snapshot.documents.compactMap { try? $0.data(as: AppUser.self) }
    }
}

