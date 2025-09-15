import SwiftUI

/// ViewModel for InspireView that fetches and stores inspirational quotes
@MainActor
final class InspireViewModel: ObservableObject {
    
    // MARK: - Published properties for the View
    @Published var quoteText: String = ""
    @Published var author: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // MARK: - Private task for async operations
    private var task: Task<Void, Never>?
    
    // MARK: - Initializer
    init() {
        // Load last saved quote from UserDefaults
        if let saved = UserDefaults.standard.loadQuote() {
            self.quoteText = saved.content
            self.author = saved.author
        }
    }
    
    // MARK: - Fetch a new quote from API
    func fetchQuote(maxLength: Int = 100) {
        // Cancel any previous ongoing task
        task?.cancel()
        
        task = Task {
            isLoading = true
            errorMessage = nil
            
            // Build URL for API
            guard let url = URL(string: "https://api.realinspire.live/v1/quotes/random?maxLength=\(maxLength)") else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            
            do {
                // Fetch data asynchronously
                let (data, response) = try await URLSession.shared.data(from: url)
                
                // Check HTTP response
                guard let http = response as? HTTPURLResponse,
                      (200...299).contains(http.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                // Decode response as an array of quotes
                let decoded = try JSONDecoder().decode([InspireQuote].self, from: data)
                
                if let first = decoded.first {
                    // Update published properties
                    quoteText = first.content
                    author = first.author
                    
                    // Save the fetched quote locally
                    let savedQuote = InspireQuote(content: first.content, author: first.author)
                    UserDefaults.standard.saveQuote(savedQuote)
                    
                } else {
                    errorMessage = "No quote found"
                }
                
            } catch {
                errorMessage = "Failed to load quote: \(error.localizedDescription)"
            }
            
            isLoading = false
        }
    }
    
    // MARK: - Cancel any ongoing fetch
    func cancel() {
        task?.cancel()
    }
}

