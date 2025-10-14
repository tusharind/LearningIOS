import Foundation
import SwiftUI
import UIKit

class MemoryDetailViewModel {
    private let entry: MemoryEntry
    
    init(entry: MemoryEntry) {
        self.entry = entry
    }
    
    // MARK: - Data Accessors
    
    var image: UIImage? {
        StorageManager.shared.loadImage(from: entry.imagePath)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: entry.timestamp)
    }
    
    var coordinatesText: String {
        String(format: "Lat: %.4f, Lon: %.4f", entry.latitude, entry.longitude)
    }
}
