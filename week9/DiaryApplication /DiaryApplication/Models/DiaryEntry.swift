import Foundation

/// Represents a single diary entry
struct DiaryEntry: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var tag: String
    var date: Date
    var fontName: String
    
    /// Sample data for previews
    static var sampleData: [DiaryEntry] {
        [
            DiaryEntry(
                title: "My First Entry",
                content: "Today I started my new diary app. Feeling excited!",
                tag: "Personal",
                date: Date(),
                fontName: "System"
            ),
            DiaryEntry(
                title: "Work Notes",
                content: "Finished implementing the network module for the project.",
                tag: "Work",
                date: Date(),
                fontName: "Helvetica"
            ),
            DiaryEntry(
                title: "Travel Plans",
                content: "Planning a trip to the mountains next month.",
                tag: "Travel",
                date: Date(),
                fontName: "Georgia"
            )
        ]
    }
}

