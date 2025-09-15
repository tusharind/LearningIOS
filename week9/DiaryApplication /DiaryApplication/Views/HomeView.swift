import SwiftUI

/// Main Home screen showing diary entries and search
struct HomeView: View {
    
    // MARK: - State
    @StateObject private var viewModel = HomeViewModel()
    @State private var showEditor = false
    @State private var editingEntry: DiaryEntry? = nil
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                searchBar
                entriesList
            }
            .background(Color.background.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // Gradient Title
                    Text("Reflections")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue, Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                }
                addButton
            }
            .sheet(isPresented: $showEditor, onDismiss: {
                viewModel.loadEntries() // Refresh list after editing
            }) {
                EditorView(viewModel: EditorViewModel(entry: editingEntry))
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Search bar at the top
    private var searchBar: some View {
        TextField("Search...", text: $viewModel.searchText)
            .padding(10)
            .background(Color.cardBG)
            .cornerRadius(10)
            .padding(.horizontal)
            .foregroundColor(.textPrimary)
    }
    
    /// List of filtered entries
    private var entriesList: some View {
        List {
            ForEach(viewModel.filteredEntries) { entry in
                entryRow(entry)
                    .listRowBackground(Color.cardBG)
            }
            .onDelete { indexSet in
                indexSet.map { viewModel.filteredEntries[$0] }
                    .forEach(viewModel.deleteEntry)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    /// A single entry row as a button to open Editor
    private func entryRow(_ entry: DiaryEntry) -> some View {
        Button {
            editingEntry = entry
            showEditor = true
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(PreferencesStore.shared.font(for: entry.fontName, size: 18))
                    .foregroundColor(.textPrimary)
                Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .foregroundColor(.textSecondary)
            }
            .padding(.vertical, 6)
        }
    }
    
    /// Toolbar plus button
    private var addButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                editingEntry = nil
                showEditor = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.accent)
            }
        }
    }
}
