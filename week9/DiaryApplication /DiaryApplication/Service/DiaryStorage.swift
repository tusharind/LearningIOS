import Foundation

/// Handles persistent storage of diary entries using JSON files
final class DiaryStorage {
    
    static let shared = DiaryStorage()
    private let fileName = "diary_entries.json"
    
    private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
    
    private init() {}
    
    /// Load all diary entries from storage
    func loadEntries() -> [DiaryEntry] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return (try? decoder.decode([DiaryEntry].self, from: data)) ?? []
    }
    
    /// Save all diary entries to storage
    private func saveEntries(_ entries: [DiaryEntry]) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(entries) {
            try? data.write(to: fileURL, options: [.atomicWrite, .completeFileProtection])
        }
    }
    
    /// Add a new entry or update an existing one
    func addOrUpdate(entry: DiaryEntry) {
        var entries = loadEntries()
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
        } else {
            entries.append(entry)
        }
        saveEntries(entries)
    }
    
    /// Delete an entry
    func delete(entry: DiaryEntry) {
        var entries = loadEntries()
        entries.removeAll { $0.id == entry.id }
        saveEntries(entries)
    }
}

