import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    // Persistent container for Core Data
    let container: NSPersistentContainer

    // MARK: - Initializer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NewsAppModel")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(
                fileURLWithPath: "/dev/null"
            )
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError(
                    "Failed to load Core Data store: \(error.localizedDescription)"
                )
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
