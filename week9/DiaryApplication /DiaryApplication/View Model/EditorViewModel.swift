import SwiftUI

/// ViewModel for creating or editing a diary entry
/// Handles validation, font selection, and saving the entry
final class EditorViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// The diary entry being created or edited
    @Published var entry: DiaryEntry
    
    /// Selected font for the entry
    @Published var selectedFont: String
    
    /// Stores any validation or save errors
    @Published var errorMessage: String?
    
    // MARK: - Private Properties
    /// Calendar instance for date comparisons
    private let calendar = Calendar.current
    
    /// Reference to all entries (for duplicate date validation)
    private var allEntries: [DiaryEntry]
    
    // MARK: - Initializer
    init(entry: DiaryEntry? = nil, allEntries: [DiaryEntry] = []) {
        self.allEntries = allEntries
        
        if let entry = entry {
            self.entry = entry
            self.selectedFont = entry.fontName ?? PreferencesStore.shared.selectedFontName
        } else {
            self.entry = DiaryEntry(
                title: "",
                content: "",
                tag: "Personal",
                date: Date(),
                fontName: PreferencesStore.shared.selectedFontName
            )
            self.selectedFont = PreferencesStore.shared.selectedFontName
        }
    }
    
    // MARK: - Public Methods
    /// Validates and saves the entry
    func saveEntry() -> Bool {
        // Validate title
        guard !entry.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Title cannot be empty."
            return false
        }
        
        //  Validate date (no future dates)
        if entry.date > Date() {
            errorMessage = "Cannot select a future date."
            return false
        }
        
        //  Load latest entries from storage
        let currentEntries = DiaryStorage.shared.loadEntries()
        
        // Check for duplicate date (ignore if editing the same entry)
        if currentEntries.contains(where: { calendar.isDate($0.date, inSameDayAs: entry.date) && $0.id != entry.id }) {
            errorMessage = "An entry for this date already exists."
            return false
        }
        
        // Assign selected font to entry
        entry.fontName = selectedFont
        
        //  Save entry to storage
        DiaryStorage.shared.addOrUpdate(entry: entry)
        
        return true
    }
}

