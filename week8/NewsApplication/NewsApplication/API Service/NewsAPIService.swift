import Foundation

final class NewsAPIService {
    
    // Single shared instance (classic singleton pattern)
    static let shared = NewsAPIService()
    private init() {}
    
    // API details
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us"
    private let apiKey  = "0c3aa7a3c440477785405ea710abf9e3"
    
    // Main function: pull articles, optionally filtered by category
    func fetchArticles(for category: String = "All") async throws -> [Article] {
        
        // If category is "All" → no filter, else encode the string safely
        let categoryQuery: String
        if category == "All" {
            categoryQuery = ""
        } else {
            let safeCategory = category
                .lowercased()
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            categoryQuery = "&category=\(safeCategory)"
        }
        
        // Build full URL
        let urlString = "\(baseURL)&apiKey=\(apiKey)\(categoryQuery)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // Perform the actual request
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(NewsResponse.self, from: data)
            return response.articles
        } catch {
            // Just rethrow the error so the ViewModel can handle it
            throw error
        }
    }
}
