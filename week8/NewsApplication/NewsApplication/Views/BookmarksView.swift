import SwiftUI

struct BookmarksView: View {
    
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        NavigationStack {
            
            // Show message if there’s nothing saved
            if viewModel.bookmarkedArticles.isEmpty {
                VStack {
                    Text("No bookmarks yet.")
                        .foregroundColor(.secondary)
                        .italic()
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            } else {
                // Otherwise show the list of saved articles
                List(viewModel.bookmarkedArticles) { article in
                    NavigationLink {
                        ArticleDetailView(
                            viewModel: viewModel,
                            article: article
                        )
                    } label: {
                        BookmarkedRowView(article: article)
                            .padding(.vertical, 4) // small breathing space
                    }
                }
                .listStyle(.plain)
            }
        }
        // Top navigation title
        .navigationTitle("Bookmarks")
    }
}
