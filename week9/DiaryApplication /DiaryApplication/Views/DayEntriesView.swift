import SwiftUI

/// Displays all diary entries for a specific day
struct DayEntriesView: View {
    
    // MARK: - Input
    let date: Date
    
    // MARK: - Environment
    @EnvironmentObject var homeVM: HomeViewModel
    
    // MARK: - State
    @State private var selectedEntry: DiaryEntry? = nil
    @State private var showEditor = false
    
    // MARK: - Computed Properties
    
    /// Entries for the selected date
    private var entriesForDate: [DiaryEntry] {
        homeVM.entries.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
    
    /// Formatted string for navigation title
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter.string(from: date)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                if entriesForDate.isEmpty {
                    Text("No entries for this day.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(entriesForDate) { entry in
                        entryRow(entry)
                    }
                    .onDelete(perform: deleteEntry)
                }
            }
            .navigationTitle(formattedDate)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
            }
            .sheet(isPresented: $showEditor) {
                if let entry = selectedEntry {
                    EditorView(viewModel: EditorViewModel(entry: entry, allEntries: homeVM.entries))
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Row for a single entry
    private func entryRow(_ entry: DiaryEntry) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(entry.title)
                .font(.headline)
            Text(entry.content)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
        .contentShape(Rectangle()) // make whole row tappable
        .onTapGesture {
            selectedEntry = entry
            showEditor = true
        }
    }
    
    /// Add button in navigation bar
    private var addButton: some View {
        Button(action: addNewEntry) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Actions
    
    /// Open editor for new entry
    private func addNewEntry() {
        selectedEntry = DiaryEntry(
            title: "",
            content: "",
            tag: "Personal",
            date: date,
            fontName: PreferencesStore.shared.selectedFontName
        )
        showEditor = true
    }
    
    /// Delete entries at the given offsets
    private func deleteEntry(at offsets: IndexSet) {
        offsets.map { entriesForDate[$0] }
            .forEach(homeVM.deleteEntry)
    }
}

