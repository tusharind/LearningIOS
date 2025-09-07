import CoreData
import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var articles: [Article] = []
    @Published var bookmarkedArticles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let context: NSManagedObjectContext
    private var fetchTask: Task<Void, Never>? // track ongoing fetch

    // MARK: - Init
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchBookmarks()
    }

    // MARK: - Fetch Articles (via Service)
    func fetchArticles(for category: String = "All") {
        // Cancel any previous fetch
        fetchTask?.cancel()

        fetchTask = Task {
            await _fetchArticles(for: category)
        }
    }

    private func _fetchArticles(for category: String) async {
        guard !Task.isCancelled else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let fetchedArticles = try await NewsAPIService.shared.fetchArticles(for: category)
            try Task.checkCancellation()
            articles = Array(fetchedArticles)
        } catch is CancellationError {
            // ignore
        } catch {
            errorMessage = "Failed to fetch articles: \(error.localizedDescription)"
        }
    }

    // MARK: - Bookmark Logic
    func addBookmark(_ article: Article) {
        let entity = BookmarkedArticle(context: context)
        entity.url = article.url
        entity.title = article.title
        entity.desc = article.description
        entity.urlToImage = article.urlToImage
        saveContext()
        fetchBookmarks()
    }

    func removeBookmark(_ article: Article) {
        let request: NSFetchRequest<BookmarkedArticle> = BookmarkedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "url == %@", article.url)

        if let results = try? context.fetch(request) {
            results.forEach { context.delete($0) }
            saveContext()
            fetchBookmarks()
        }
    }

    func toggleBookmark(_ article: Article) {
        isBookmarked(article) ? removeBookmark(article) : addBookmark(article)
    }

    func isBookmarked(_ article: Article) -> Bool {
        bookmarkedArticles.contains { $0.url == article.url }
    }

    // MARK: - Core Data Helper Functions
    private func fetchBookmarks() {
        let request: NSFetchRequest<BookmarkedArticle> = BookmarkedArticle.fetchRequest()
        if let results = try? context.fetch(request) {
            bookmarkedArticles = results.compactMap {
                guard let url = $0.url else { return nil }
                return Article(
                    title: $0.title ?? "No Title",
                    description: $0.desc,
                    urlToImage: $0.urlToImage,
                    url: url
                )
            }
        }
    }

    private func saveContext() {
        do { try context.save() } catch {
            print("Core Data save error: \(error)")
        }
    }
}
