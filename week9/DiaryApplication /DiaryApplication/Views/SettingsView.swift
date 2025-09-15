import SwiftUI

/// Settings screen allowing users to customize appearance (dark mode & font)
struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel() // Settings data
    
    var body: some View {
        NavigationView {
            Form {
                
                // MARK: - Appearance Section
                Section(header: Text("Appearance")
                            .foregroundColor(Color("TextPrimary"))) {
                    
                    // Dark Mode Toggle
                    Toggle("Dark Mode", isOn: $viewModel.darkModeEnabled)
                        .onChange(of: viewModel.darkModeEnabled) { newValue in
                            // Update global preferences
                            PreferencesStore.shared.darkModeEnabled = newValue
                        }
                        .tint(Color("AccentColor")) // use custom accent
                    
                    // Font Picker
                    Picker("Font", selection: $viewModel.selectedFont) {
                        ForEach(viewModel.availableFonts, id: \.self) { font in
                            Text(font)
                                .foregroundColor(Color("TextPrimary"))
                        }
                    }
                    .onChange(of: viewModel.selectedFont) { newFont in
                        // Update global preferences
                        PreferencesStore.shared.selectedFontName = newFont
                    }
                }
            }
            .scrollContentBackground(.hidden) // remove default Form background
            .background(Color("Background").ignoresSafeArea())
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

