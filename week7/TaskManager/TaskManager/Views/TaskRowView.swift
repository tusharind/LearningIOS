import SwiftUI

/// A single row view representing a task with title, due date, and completion toggle.
struct TaskRowView: View {
    // MARK: - Properties

    /// The task entity to display
    var task: TaskEntity

    /// Action to toggle the task's completion status
    var toggleAction: () -> Void

    // MARK: - Body

    var body: some View {
        HStack(spacing: 12) {
            // MARK: Completion Toggle Button

            Button(action: toggleAction) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
                    .imageScale(.large)
            }
            .buttonStyle(BorderlessButtonStyle()) // Prevent row selection conflict

            // MARK: Task Details

            VStack(alignment: .leading, spacing: 2) {
                // Task Title with strikethrough if completed
                Text(task.title ?? "Untitled Task")
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                    .lineLimit(1)
            }

            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle()) // Make the entire row tappable for gestures if needed
    }
}
