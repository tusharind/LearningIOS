import SwiftUI

struct ArticleDetailView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    let article: Article

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // MARK: - Article Image from API
                if let urlStr = article.urlToImage,
                   let url = URL(string: urlStr){
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                                .clipped()
                        case .failure:
                            Color.gray.opacity(0.3)
                                .frame(height: 250)
                                .frame(maxWidth: .infinity)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // MARK: - Article Content
                VStack(alignment: .leading, spacing: 12) {
                    
                    // Title
                    Text(article.title.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.title2)
                        .bold()
                        .fixedSize(horizontal: false, vertical: true)

                    // Description
                    if let desc = article.description,
                       !desc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Text(desc.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    // MARK: - Buttons and Links
                    HStack {
                        // Bookmark Button
                        Button(action: { viewModel.toggleBookmark(article) }) {
                            HStack {
                                Image(systemName: viewModel.isBookmarked(article) ? "bookmark.fill" : "bookmark")
                                Text(viewModel.isBookmarked(article) ? "Bookmarked" : "Bookmark")
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }

                        Spacer()

                        // Read Full Article Link
                        if let url = URL(string: article.url) {
                            Link("Read Full Article", destination: url)
                                .font(.body.bold())
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
    }
}

