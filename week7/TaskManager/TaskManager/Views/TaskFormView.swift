import CoreData
import SwiftUI

/// View for creating a new task with title and due date.
/// Handles form validation and saving to Core Data.
struct TaskFormView: View {
    // MARK: - Environment

    /// Dismiss action provided by SwiftUI environment
    @Environment(\.dismiss) private var dismiss

    // MARK: - State Objects

    /// ViewModel managing form state, validation, and saving
    @StateObject private var viewModel: TaskFormViewModel

    // MARK: - Initializer

    /// Initializes the TaskFormView with a Core Data context
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TaskFormViewModel(context: context))
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Form {
                // MARK: Task Details Section

                Section(header: Text("Task Details")) {
                    TextField("Title", text: $viewModel.title)
                        .autocapitalization(.sentences)

                    DatePicker("Due Date",
                               selection: $viewModel.dueDate,
                               displayedComponents: .date)
                }

                // MARK: Validation Message

                // Show a warning if title is empty or duplicate
                if !viewModel.isValid && !viewModel.title.isEmpty {
                    Text("Task already exists or title is empty")
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.top, 2)
                }
            }
            .navigationTitle("New Task")

            // MARK: Toolbar Actions

            .toolbar {
                // Cancel button
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                // Save button (disabled if form is invalid)
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveTask()
                        dismiss()
                    }
                    .disabled(!viewModel.isValid)
                }
            }
        }
    }
}
