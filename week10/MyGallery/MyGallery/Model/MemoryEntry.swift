import Foundation

struct MemoryEntry: Identifiable, Codable {
    let id: UUID
    let imagePath: String
    let latitude: Double
    let longitude: Double
    let placeName: String?   
    let timestamp: Date
    
    init(id: UUID = UUID(),
         imagePath: String,
         latitude: Double,
         longitude: Double,
         placeName: String? = nil,
         timestamp: Date = Date()) {
        self.id = id
        self.imagePath = imagePath
        self.latitude = latitude
        self.longitude = longitude
        self.placeName = placeName
        self.timestamp = timestamp
    }
}

