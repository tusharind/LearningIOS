import SwiftUI

/// Displays a single diary entry in detail, with options to edit or delete
struct DetailView: View {
    
    // MARK: - State & Environment
    @StateObject var viewModel: DetailViewModel
    @State private var showEditor = false
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Entry title
            Text(viewModel.entry.title)
                .font(PreferencesStore.shared.font(for: viewModel.entry.fontName, size: 24))
                .bold()
            
            // Entry date
            Text(viewModel.entry.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Entry tag
            Text("Tag: \(viewModel.entry.tag)")
                .font(.footnote)
                .padding(.bottom, 8)
            
            // Entry content
            ScrollView {
                Text(viewModel.entry.content)
                    .font(PreferencesStore.shared.font(for: viewModel.entry.fontName, size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Entry Detail")
        .toolbar { toolbarContent }
        .sheet(isPresented: $showEditor, onDismiss: refreshEntry) {
            EditorView(viewModel: EditorViewModel(entry: viewModel.entry))
        }
    }
    
    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            HStack(spacing: 16) {
                // Edit button
                Button("Edit") {
                    showEditor = true
                }
                
                // Delete button
                Button(role: .destructive) {
                    viewModel.deleteEntry()
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
    }
    
    // MARK: - Actions
    
    /// Refresh the entry after editing
    private func refreshEntry() {
        if let updated = DiaryStorage.shared.loadEntries().first(where: { $0.id == viewModel.entry.id }) {
            viewModel.updateEntry(updated)
        }
    }
}

