import SwiftUI

// MARK: - Reusable Stat View
struct Stats: View {
    let title: String
    let value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .fontWeight(.bold)
        }
    }
}
