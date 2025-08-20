import SwiftUI

struct ContentView: View {
    // single source of truth for both Dark and Light mode
    @State private var isDarkMode: Bool = false

    var body: some View {
        ZStack {
            // MARK: Background Gradient

            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea() // to make gradient cover entire screen

            // MARK: vertical stack for content

            VStack(spacing: 40) {
                // Title
                Text("Settings Panel")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(isDarkMode ? .white : .black)
                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)

                // settings Panel (child view) with two-way binding
                SettingsPanel(isDarkMode: $isDarkMode)
                    .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 60)
            .animation(.easeInOut, value: isDarkMode) // for smooth animation when toggling
        }
        
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: - preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
