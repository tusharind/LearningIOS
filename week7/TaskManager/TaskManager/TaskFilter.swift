enum TaskFilter: Int, CaseIterable {
    case all, completed, pending

    var title: String {
        switch self {
        case .all: return "All"
        case .completed: return "Completed"
        case .pending: return "Pending"
        }
    }
}
