import Foundation
import Combine
import SwiftUI

/// Singleton for storing and managing user preferences such as font selection and dark mode
final class PreferencesStore: ObservableObject {
    
    // MARK: - Singleton instance
    static let shared = PreferencesStore()
    
    // MARK: - Published properties
    
    /// Currently selected font name
    @Published var selectedFontName: String {
        didSet {
            // Persist selection to UserDefaults whenever it changes
            UserDefaults.standard.set(selectedFontName, forKey: Keys.selectedFontName)
        }
    }
    
    /// Whether dark mode is enabled
    @Published var darkModeEnabled: Bool {
        didSet {
            // Persist dark mode preference
            UserDefaults.standard.set(darkModeEnabled, forKey: Keys.darkModeEnabled)
        }
    }
    
    // MARK: - Available fonts
    let availableFonts: [String] = [
        "System",
        "Helvetica",
        "Georgia",
        "Courier",
        "Avenir",
        "Times New Roman"
    ]
    
    // MARK: - Private initializer
    private init() {
        // Load preferences from UserDefaults or use defaults
        self.selectedFontName = UserDefaults.standard.string(forKey: Keys.selectedFontName) ?? "System"
        self.darkModeEnabled = UserDefaults.standard.bool(forKey: Keys.darkModeEnabled)
    }
    
    // MARK: - Helper method
    
    /// Returns a SwiftUI Font from a font name string
        func font(for fontName: String? = nil, size: CGFloat = 16) -> Font {
        let name = fontName ?? selectedFontName
        return name == "System" ? .system(size: size) : .custom(name, size: size)
    }
    
    // MARK: - Keys for UserDefaults
    private enum Keys {
        static let selectedFontName = "selectedFontName"
        static let darkModeEnabled = "darkModeEnabled"
    }
}

