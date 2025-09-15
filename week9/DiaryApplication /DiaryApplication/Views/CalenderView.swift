import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let calendar = Calendar.current
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Month Navigation
                HStack {
                    Button {
                        viewModel.previousMonth()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                    Text(viewModel.monthYearString())
                        .font(.title2.bold())
                    Spacer()
                    Button {
                        viewModel.nextMonth()
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                }
                .padding(.horizontal)
                
                // MARK: - Weekdays
                HStack {
                    ForEach(viewModel.daysOfWeek.indices, id: \.self) { i in
                        Text(viewModel.daysOfWeek[i])
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
                
                // MARK: - Days Grid
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.days, id: \.self) { day in
                        let isCurrentMonth =
                        day.monthInt == viewModel.date.monthInt
                        let hasEntry = viewModel.hasEntry(for: day)
                        
                        Text(
                            isCurrentMonth
                            ? "\(day.formatted(.dateTime.day()))" : ""
                        )
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 40)
                        .background(
                            Circle()
                                .foregroundStyle(
                                    hasEntry
                                    ? Color.blue.opacity(0.6)
                                    : Color.gray.opacity(
                                        isCurrentMonth ? 0.2 : 0
                                    )
                                )
                        )
                        .foregroundColor(isCurrentMonth ? .primary : .secondary)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if let entry = viewModel.entry(for: day) {
                                viewModel.selectedEntry = entry
                            }
                        }
                    }
                }
            }
            .sheet(item: $viewModel.selectedEntry) { entry in///as soon as it becomes non nill
                EditorView(viewModel: EditorViewModel(entry: entry))
            }
            .onAppear { viewModel.updateDays() }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Year so Far")
                        .font(.largeTitle.bold())
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color.blue, Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
            }
        }
    }
}
