import SwiftUI

struct ArticleListView: View {

    @ObservedObject var viewModel: NewsViewModel
    @State private var selectedCategory = "All"

    private let categories = ["All", "Business", "Sports", "Technology"]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {

                // MARK: - Segmented View for news categories
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { Text($0) }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // MARK: - List of news articles
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink {
                            ArticleDetailView(viewModel: viewModel, article: article)
                        } label: {
                            ArticleRowView(
                                article: article,
                                isBookmarked: viewModel.isBookmarked(article),
                                toggleBookmark: { viewModel.toggleBookmark(article) }
                            )
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("News")

            // MARK: - Lifecycle Events
            .task(id: selectedCategory) {
                viewModel.fetchArticles(for: selectedCategory)
            }
            .refreshable {
                viewModel.fetchArticles(for: selectedCategory)
            }
        }
    }
}
