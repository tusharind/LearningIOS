import CoreData
import SwiftUI

/// Main view displaying a list of tasks with filtering, completion toggle, and add functionality.
struct TaskListView: View {
    // MARK: - State Objects

    /// ViewModel that handles fetching, filtering, toggling, and deleting tasks
    @StateObject private var viewModel: TaskListViewModel

    /// State controlling whether the Add Task sheet is shown
    @State private var showingAddTask = false

    // MARK: - Initializer

    /// Initializes TaskListView with a Core Data context
    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TaskListViewModel(context: context))
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Segmented Picker for Task Filter

                Picker("Filter", selection: $viewModel.filter) {
                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                        Text(filter.title).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top)
                .tint(.blue)
                // Updates the task list whenever the filter changes
                .onChange(of: viewModel.filter) { _ in
                    withAnimation(.easeInOut) {
                        viewModel.fetchTasks()
                    }
                }

                // MARK: Empty State View

                if viewModel.tasks.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Image(systemName: "checklist")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.5))
                        Text("No tasks yet")
                            .foregroundColor(.gray)
                            .font(.title3)
                        Text("Tap + to add your first task")
                            .foregroundColor(.gray.opacity(0.7))
                            .font(.subheadline)
                    }
                    Spacer()
                } else {
                    // MARK: Task List

                    List {
                        ForEach(viewModel.tasks) { task in
                            TaskRowView(task: task) {
                                withAnimation(.spring()) {
                                    viewModel.toggleCompletion(task)
                                }
                            }
                        }
                        // Swipe-to-delete functionality
                        .onDelete { indexSet in
                            indexSet.map { viewModel.tasks[$0] }.forEach(viewModel.deleteTask)
                        }
                    }
                    .listStyle(.plain)
                    .transition(.opacity.combined(with: .slide))
                }
            }
            .navigationTitle("Tasks")

            // MARK: Toolbar - Add Task Button

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTask.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }

            // MARK: Add Task Sheet

            .sheet(isPresented: $showingAddTask) {
                TaskFormView(context: viewModel.context)
                    .onDisappear { viewModel.fetchTasks() }
            }

            // MARK: Fetch tasks when view appears

            .onAppear { viewModel.fetchTasks() }
        }
    }
}
