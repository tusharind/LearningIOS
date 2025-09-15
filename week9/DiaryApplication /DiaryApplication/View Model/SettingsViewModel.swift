import Foundation
import SwiftUI

/// ViewModel for managing app settings such as font and dark mode
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    /// Currently selected font
    @Published var selectedFont: String {
        didSet {
            PreferencesStore.shared.selectedFontName = selectedFont
        }
    }
    
    /// Flag indicating whether dark mode is enabled
    @Published var darkModeEnabled: Bool {
        didSet {
            PreferencesStore.shared.darkModeEnabled = darkModeEnabled
        }
    }
    
    // MARK: - Public Properties
    /// List of available fonts for the app
    let availableFonts: [String] = [
        "System",
        "Helvetica",
        "Georgia",
        "Courier",
        "Avenir",
        "Times New Roman"
    ]
    
    // MARK: - Initializer
    init() {
        // Load saved preferences or set defaults
        self.selectedFont = PreferencesStore.shared.selectedFontName
        self.darkModeEnabled = PreferencesStore.shared.darkModeEnabled
    }
    
    // MARK: - Public Methods
    /// Toggle dark mode on/off
    func toggleDarkMode() {
        darkModeEnabled.toggle()
    }
}

