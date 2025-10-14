import SwiftUI
import CoreData

@MainActor
final class NewsViewModel: ObservableObject {
    
    // Data the UI listens to
    @Published var articles: [Article] = []
    @Published var bookmarkedArticles: [Article] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Core Data context + a task to cancel/replace fetch requests
    private let context: NSManagedObjectContext
    private var fetchTask: Task<Void, Never>?
    
    // When this ViewModel is created, grab saved bookmarks right away
    init(context: NSManagedObjectContext) {
        self.context = context
        fetchBookmarks()
    }
    
    // Public function the view can call when user switches category
    func fetchArticles(for category: String = "All") {
            await fetchArticles(for: category)
    }
    
    // Actual async fetch logic, hidden from outside
    private func fetchArticles(for category: String) async {
        guard !Task.isCancelled else { return }
        
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let fetchedArticles = try await NewsAPIService.shared.fetchArticles(for: category)
            try Task.checkCancellation()
            articles = Array(fetchedArticles)
        } catch is CancellationError {
            // cancelled on purpose → ignore
        } catch {
            errorMessage = "Failed to load news: \(error.localizedDescription)"
        }
    }
    
    // MARK: - Bookmark operations
    
    func toggleBookmark(_ article: Article) {
        isBookmarked(article) ? removeBookmark(article) : addBookmark(article)
    }
    
    func isBookmarked(_ article: Article) -> Bool {
        bookmarkedArticles.contains { $0.url == article.url }
    }
    
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
    
    // MARK: - Core Data helpers
    
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
        do {
            try context.save()
        } catch {
            print("Core Data save failed: \(error)")
        }
    }
}
