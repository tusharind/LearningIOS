import SwiftUI

struct BookmarkedRowView: View {
    // MARK: - Properties
    let article: Article

    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // MARK: - Thumbnail Image
            if let urlStr = article.urlToImage,
                let url = URL(string: urlStr)
            {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 100, height: 70)
                .cornerRadius(8)
                .clipped()
            }

            // MARK: - Article Text
            VStack(alignment: .leading, spacing: 4) {
                // Title
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)

                // Description (if available)
                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()
        }
        .padding(.vertical, 6)
    }
}
