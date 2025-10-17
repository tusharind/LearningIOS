import SwiftUI

import Foundation
import FirebaseAuth

@MainActor
final class SettingsViewModel: ObservableObject {
    
    /// Logs out the current Firebase user
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
