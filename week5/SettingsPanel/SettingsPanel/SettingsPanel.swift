// MARK: - settings panel View

import SwiftUI

struct SettingsPanel: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        VStack(spacing: 30) {
            ToggleTheme(isDarkMode: $isDarkMode)

            PresentThemeOnScreen(isDarkMode: isDarkMode)

            Spacer()
        }
        .padding()
    }
}
