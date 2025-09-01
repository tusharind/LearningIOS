import CoreData
import SwiftUI

/// ViewModel for managing the list of tasks, including fetching, filtering, toggling completion, and deleting tasks.
class TaskListViewModel: ObservableObject {
    // MARK: - Published Properties

    /// Array of tasks currently displayed based on filter
    @Published var tasks: [TaskEntity] = []

    /// Current filter applied to tasks (all, completed, pending)
    @Published var filter: TaskFilter = .all

    // MARK: - Private Properties

    /// Core Data context used for fetching and saving tasks
    private let viewContext: NSManagedObjectContext

    // MARK: - Computed Properties

    var context: NSManagedObjectContext { viewContext }

    // MARK: - Initializer

    /// Initializes the ViewModel with a Core Data context
    init(context: NSManagedObjectContext) {
        viewContext = context
        fetchTasks() // Initial fetch
    }

    // MARK: - Fetch Tasks

    /// Fetch tasks from Core Data based on the current filter
    func fetchTasks() {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.dueDate, ascending: true)]

        // Apply predicate based on filter
        switch filter {
        case .all:
            request.predicate = nil
        case .completed:
            request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: true))
        case .pending:
            request.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: false))
        }

        do {
            tasks = try viewContext.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }

    // MARK: - Task Actions

    /// Toggle the completion status of a task
    func toggleCompletion(_ task: TaskEntity) {
        task.isCompleted.toggle()
        saveContext()
    }

    /// Delete a task from Core Data
    func deleteTask(_ task: TaskEntity) {
        viewContext.delete(task)
        saveContext()
    }

    // MARK: - Private Helpers

    /// Save changes to Core Data and refresh the task list
    private func saveContext() {
        do {
            try viewContext.save()
            fetchTasks()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
