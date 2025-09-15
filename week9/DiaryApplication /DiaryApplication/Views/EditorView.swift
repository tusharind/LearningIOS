import SwiftUI

/// View for creating or editing a diary entry
struct EditorView: View {
    
    // MARK: - Environment & State
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: EditorViewModel
    @State private var showAlert = false
    
    // MARK: - Static Data
    private let tags = ["Personal", "Work", "Learning", "Travel", "Other"]
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                titleSection
                contentSection
                tagSection
                dateSection
                fontSection
            }
            .navigationTitle("Diary Entry")
            .toolbar { toolbarContent }
            .alert("Error", isPresented: $showAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
    }
    
    // MARK: - Form Sections
    private var titleSection: some View {
        Section(header: Text("Title")) {
            TextField("Enter title", text: $viewModel.entry.title)
        }
    }
    
    private var contentSection: some View {
        Section(header: Text("Content")) {
            TextEditor(text: $viewModel.entry.content)
                .font(PreferencesStore.shared.font(for: viewModel.entry.fontName))
                .frame(height: 200)
        }
    }
    
    private var tagSection: some View {
        Section(header: Text("Tag")) {
            Picker("Tag", selection: $viewModel.entry.tag) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag).tag(tag)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    private var dateSection: some View {
        Section(header: Text("Date")) {
            DatePicker(
                "Select Date",
                selection: $viewModel.entry.date,
                in: ...Date(),
                displayedComponents: .date
            )
        }
    }
    
    private var fontSection: some View {
        Section(header: Text("Font")) {
            Picker("Font", selection: $viewModel.selectedFont) {
                ForEach(PreferencesStore.shared.availableFonts, id: \.self) { font in
                    Text(font).tag(font)
                }
            }
        }
    }
    
    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel") { dismiss() }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Save") {
                if viewModel.saveEntry() {
                    dismiss()
                } else {
                    showAlert = true
                }
            }
        }
    }
}

