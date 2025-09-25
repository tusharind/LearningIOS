import SwiftUI

struct ArticleRowView: View {

    let article: Article
    let isBookmarked: Bool
    let toggleBookmark: () -> Void

    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // MARK: - Thumbnail Image
            if let urlStr = article.urlToImage,
               let url = URL(string: urlStr) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.3))
                            Image(systemName: "photo")
                                .foregroundColor(.white.opacity(0.7))
                        }
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 100, height: 80)
                .cornerRadius(10)
                .shadow(radius: 2)
            }

            // MARK: - Article Text
            VStack(alignment: .leading, spacing: 6) {
                // Title
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(2)

                // Description (if available)
                if let desc = article.description {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
            }
            .padding(.vertical, 4)

            Spacer()

            // MARK: - Bookmark Button
            Button(action: toggleBookmark) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.system(size: 20, weight: .semibold))
                    .padding(8)
                    .background(
                        Circle()
                            .fill(isBookmarked ? Color.green.opacity(0.85) : Color.blue.opacity(0.85))
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 2)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding(.vertical, 8)
    }
}
