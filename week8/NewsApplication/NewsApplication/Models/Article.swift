import Foundation

struct Article: Codable, Identifiable {
    // Use URL as unique identifier
    var id: String { url }

    let title: String
    let description: String?
    let urlToImage: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case title, description, urlToImage, url
    }
}

struct NewsResponse: Codable {
    let articles: [Article]
}

enum categories{
      case .All = "All"
      case .Sports = "Sports"
      case .Business = "Business"
      case .Technology = "Technology"
}
