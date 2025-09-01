import CoreData

/// Manages the Core Data stack for the Task Manager app
struct PersistenceController {
    // MARK: - Shared Instance

    /// Singleton instance for the app
    static let shared = PersistenceController()

    // MARK: - Preview Setup

    /// In-memory preview controller for SwiftUI previews (no sample tasks)
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        return result
    }()

    // MARK: - Core Data Container

    /// NSPersistentContainer for managing Core Data stack
    let container: NSPersistentContainer

    // MARK: - Initializer

    /// Initializes the persistence controller
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TaskManager")

        // Configure in-memory store if required
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        // Load persistent stores
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error loading persistent stores: \(error), \(error.userInfo)")
            }
        }

        // Merge changes automatically from parent context
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
