import Foundation

final class NewsAPIService {
    // MARK: - Singleton Instance
    static let shared = NewsAPIService()
    private init() {}

    private let apiKey = "0c3aa7a3c440477785405ea710abf9e3"
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us"

    // MARK: - Fetch Articles
    func fetchArticles(for category: String = "All") async throws -> [Article] {
        // Percent-encode category to prevent invalid URL
        let categoryQuery =
            category != "All"
            ? "&category=\(category.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            : ""
        let urlString = "\(baseURL)&apiKey=\(apiKey)\(categoryQuery)"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try decoder.decode(NewsResponse.self, from: data)
            return response.articles
        } catch {
            // Pass detailed error up to the ViewModel
            throw error
        }
    }
    
}
