// MARK: - theme toggle component

import SwiftUI

struct ToggleTheme: View {
    @Binding var isDarkMode: Bool

    var body: some View {
        Toggle(isOn: $isDarkMode) {
            Text("Dark Mode")
                .font(.headline)
        }
        .toggleStyle(SwitchToggleStyle(tint: .blue))
        .padding()
    }
}
