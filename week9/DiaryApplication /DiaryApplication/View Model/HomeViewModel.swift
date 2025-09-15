import Foundation
import SwiftUI
import Combine

/// ViewModel for the Home tab
/// Manages diary entries, search functionality, and filtered results
final class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// All diary entries loaded from storage
    @Published var entries: [DiaryEntry] = []
    
    /// Current search text entered by the user
    @Published var searchText: String = ""
    
    /// Entries filtered based on the search text
    @Published var filteredEntries: [DiaryEntry] = []
    
    // MARK: - Private Properties
    /// Combine cancellables for handling search text updates
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init() {
        loadEntries()
        setupSearch()
    }
    
    // MARK: - Public Methods
    /// Load all entries from persistent storage
    func loadEntries() {
        entries = DiaryStorage.shared.loadEntries()
        filterEntries()
    }
    
    /// Delete a specific diary entry
    /// The entry to delete
    func deleteEntry(_ entry: DiaryEntry) {
        DiaryStorage.shared.delete(entry: entry)
        loadEntries()
    }
    
    // MARK: - Private Methods
    /// Setup search functionality to filter entries as searchText changes
    private func setupSearch() {
        $searchText
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.filterEntries()
            }
            .store(in: &cancellables)
    }
    
    /// Filter entries based on the current search text
    private func filterEntries() {
        let trimmedText = searchText.trimmingCharacters(in: .whitespaces)
        
        if trimmedText.isEmpty {
            // No search text: show all entries sorted by date descending
            filteredEntries = entries.sorted { $0.date > $1.date }
        } else {
            // Filter by title, content, or tag
            let lowercased = trimmedText.lowercased()
            filteredEntries = entries
                .filter {
                    $0.title.lowercased().contains(lowercased) ||
                    $0.content.lowercased().contains(lowercased) ||
                    $0.tag.lowercased().contains(lowercased)
                }
                .sorted { $0.date > $1.date }
        }
    }
}

