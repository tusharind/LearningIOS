import SwiftUI

@main
struct NewsAppApp: App {
    // Core Data persistence controller
    let persistenceController = PersistenceController.shared

    // Single ViewModel for news + bookmarks
    @StateObject private var newsViewModel: NewsViewModel

    // MARK: - Initializer
    init() {
        let context = persistenceController.container.viewContext
        _newsViewModel = StateObject(wrappedValue: NewsViewModel(context: context))
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                // Main News List
                ArticleListView(viewModel: newsViewModel)
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }

                // Bookmarks Tab
                BookmarksView(viewModel: newsViewModel)
                    .tabItem {
                        Label("Bookmarks", systemImage: "bookmark.fill")
                    }
            }
        }
    }
}

