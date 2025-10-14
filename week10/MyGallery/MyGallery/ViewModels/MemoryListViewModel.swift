import Foundation
import UIKit

class MemoryListViewModel: ObservableObject {
    @Published private(set) var entries: [MemoryEntry] = []
    
    private let storageKey = "savedMemories"
    
    init() {
        loadEntries()
    }
    
    // MARK: - Add Memory
    func addEntry(image: UIImage, location: (lat: Double, lon: Double), placeName: String? = nil) {
        guard let imagePath = StorageManager.shared.saveImage(image) else {
            print("Failed to save image")
            return
        }
        
        let entry = MemoryEntry(
            imagePath: imagePath,
            latitude: location.lat,
            longitude: location.lon,
            placeName: placeName
        )
        
        DispatchQueue.main.async {  // ensure UI updates
            self.entries.insert(entry, at: 0)
            self.saveEntries()
        }
        
        NotificationManager.shared.scheduleReminder(for: entry)
    }
    
    // MARK: - Delete Memory
    func deleteEntry(at indexSet: IndexSet) {
        for index in indexSet {
            let entry = entries[index]
            StorageManager.shared.deleteImage(at: entry.imagePath)
        }
        entries.remove(atOffsets: indexSet)
        saveEntries()
    }
    
    // MARK: - Persistence
    private func saveEntries() {
        do {
            let data = try JSONEncoder().encode(entries)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save entries: \(error.localizedDescription)")
        }
    }
    
    private func loadEntries() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            entries = try JSONDecoder().decode([MemoryEntry].self, from: data)
        } catch {
            print("Failed to load entries: \(error.localizedDescription)")
        }
    }
}

