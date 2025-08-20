import SwiftUI

// MARK: - reusable cards each dislaying an image and a text over a card like background
struct CardView: View {
    let title: String
    let imageName: String
    let backgroundColor: Color

    init(
        title: String,
        imageName: String,
        backgroundColor: Color = Color(.systemGray6)
    ) {
        self.title = title
        self.imageName = imageName
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(width: 310)

            Text(title)
                .font(.headline).foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 6)
        }
        .padding()
        .frame(width: 350)
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}
