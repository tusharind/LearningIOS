import SwiftUI

struct ArticleListView: View {

    @ObservedObject var viewModel: NewsViewModel
    @State private var selectedCategory = "All"

    private let categories = ["All", "Business", "Sports", "Technology"]

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color for a cleaner look
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 12) {

                    // MARK: - Segmented View for news categories
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                    .padding(.top, 8)

                    // MARK: - Content Area
                    if viewModel.isLoading {
                        // A centered progress indicator so the UI feels responsive
                        VStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(1.4)
                            Text("Fetching the latest news...")
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .padding(.top, 4)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    } else if let error = viewModel.errorMessage {
                        VStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 40))
                            Text(error)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .font(.body)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                    } else {
                        // List of news articles styled nicely
                        List {
                            ForEach(viewModel.articles) { article in
                                NavigationLink {
                                    ArticleDetailView(viewModel: viewModel, article: article)
                                } label: {
                                    ArticleRowView(
                                        article: article,
                                        isBookmarked: viewModel.isBookmarked(article),
                                        toggleBookmark: { viewModel.toggleBookmark(article) }
                                    )
                                    .padding(.vertical, 6) // breathing space per row
                                }
                                .listRowBackground(Color.white) // keeps rows clean
                            }
                        }
                        .listStyle(.insetGrouped) // modern grouped style
                        .scrollIndicators(.hidden) // cleaner scrolling
                    }
                }
            }
            .navigationTitle("📰 News") 

            // MARK: - Lifecycle Events
            .task(id: selectedCategory) {
                // Fetch articles when category changes
                await viewModel.fetchArticles(for: selectedCategory)
            }
            .refreshable {
                // Pull-to-refresh feels natural for news
               await  viewModel.fetchArticles(for: selectedCategory)
            }
        }
    }
}
