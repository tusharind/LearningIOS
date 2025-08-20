// MARK: - present theme display component

import SwiftUI

struct PresentThemeOnScreen: View {
    var isDarkMode: Bool

    var body: some View {
        Text("Current Theme: \(isDarkMode ? "Dark" : "Light")")
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(isDarkMode ? Color.black : Color.white)
            .foregroundColor(isDarkMode ? Color.white : Color.black)
            .cornerRadius(12)
            .shadow(radius: 5)
    }
}
