import SwiftUI

// MARK: - main contentView
struct ContentView: View {
    var body: some View {
        // scrollView just in case content grows unexpectedly
        ScrollView {
            VStack(spacing: 20) {

                // MARK: - title for the page
                Text("Hello SwiftUI!")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding()

                // MARK: - our profile card
                ProfileCard()
                    .padding(20)
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
