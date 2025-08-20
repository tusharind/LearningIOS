import SwiftUI

// MARK: - main content view which uses the same reusable cards to display different images

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    // Heading
                    Text("Using Reusable Cards")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                        .foregroundColor(.blue.opacity(0.8))

                    // Cards
                    CardView(
                        title: "Jordan",
                        imageName: "ball",
                        backgroundColor: .blue.opacity(0.2)
                    )

                    CardView(
                        title: "Federer",
                        imageName: "ball2",
                        backgroundColor: .blue.opacity(0.2)
                    )

                    CardView(
                        title: "Tiger",
                        imageName: "ball3",
                        backgroundColor: .blue.opacity(0.2)
                    )
                    CardView(
                        title: "Tiger",
                        imageName: "ball2",
                        backgroundColor: .blue.opacity(0.2)
                    )
                }
                .padding()
            }
        }
    }
}

// MARK: - preview for display
#Preview {
    ContentView()
}
