import CoreData
import SwiftUI

/// ViewModel for managing the state and saving of a single task form.
class TaskFormViewModel: ObservableObject {
    // MARK: - Published Properties

    /// Task title entered by the user
    @Published var title: String = ""

    /// Task due date selected by the user
    @Published var dueDate: Date = .init()

    // MARK: - Private Properties

    /// Core Data context used for saving and fetching tasks
    private let viewContext: NSManagedObjectContext

    // MARK: - Initializer

    /// Initializes the ViewModel with a Core Data context
    init(context: NSManagedObjectContext) {
        viewContext = context
    }

    // MARK: - Form Validation

    /// Checks if the current form is valid
    var isValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedTitle.isEmpty
    }

    // MARK: - Save Task

    /// Saves a new task to Core Data if valid
    func saveTask() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        let newTask = TaskEntity(context: viewContext)
        newTask.id = UUID()
        newTask.title = trimmedTitle
        newTask.isCompleted = false
        newTask.dueDate = dueDate

        do {
            try viewContext.save()
        } catch {
            print("Error saving task: \(error)")
        }
    }
}
