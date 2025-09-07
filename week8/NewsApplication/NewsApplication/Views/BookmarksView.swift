import SwiftUI

struct BookmarksView: View {

    @ObservedObject var viewModel: NewsViewModel

    // MARK: - Bookmark View
    var body: some View {
        NavigationStack {
            // MARK: - Content
            if viewModel.bookmarkedArticles.isEmpty {
                // If no bookmarks
                Text("No bookmarks yet.")
                    .foregroundColor(.secondary)
                    .italic()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // Bookmarks list
                List(viewModel.bookmarkedArticles) { article in
                    NavigationLink {
                        ArticleDetailView(
                            viewModel: viewModel,
                            article: article
                        )
                    } label: {
                        BookmarkedRowView(article: article)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("Bookmarks")
    }
}
