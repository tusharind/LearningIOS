import Foundation
import SwiftUI

/// ViewModel for displaying and managing a single diary entry
/// Handles updating and deleting the entry.
final class DetailViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// The diary entry being displayed or edited
    @Published var entry: DiaryEntry
    
    /// Controls display of alert messages
    @Published var showAlert = false
    
    /// Stores the alert message text
    @Published var alertMessage = ""
    
    // MARK: - Initializer
    /// Initialize with an existing diary entry
    /// - Parameter entry: The diary entry to manage
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    // MARK: - Public Methods
    
    /// Deletes the current diary entry from storage
    func deleteEntry() {
        DiaryStorage.shared.delete(entry: entry)
    }
    
    /// Updates the current diary entry with new data
    func updateEntry(_ updatedEntry: DiaryEntry) {
        DiaryStorage.shared.addOrUpdate(entry: updatedEntry)
        entry = updatedEntry
    }
}

