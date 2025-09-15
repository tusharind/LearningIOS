import SwiftUI

/// ViewModel for CalendarView managing month, days, and diary entries
@MainActor
final class CalendarViewModel: ObservableObject {
    
    // MARK: - Published properties
    @Published var date: Date = Date()                    // Current displayed month
    @Published var days: [Date] = []                      // 6-week grid of days
    @Published var selectedEntry: DiaryEntry? = nil       // Entry selected for editing
    
    // MARK: - Private properties
    private let calendar = Calendar.current
    private var homeViewModel: HomeViewModel             // Source of diary entries
    
    // MARK: - Initializer
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        self.days = date.calendarDisplayDays
    }
    
    // MARK: - Weekday headers
    var daysOfWeek: [String] { Date.capitalizedFirstLettersOfWeekdays }
    
    // MARK: - Month navigation
    func previousMonth() {
        guard let newMonth = calendar.date(byAdding: .month, value: -1, to: date) else { return }
        date = newMonth
        updateDays()
    }
    
    func nextMonth() {
        guard let newMonth = calendar.date(byAdding: .month, value: 1, to: date) else { return }
        date = newMonth
        updateDays()
    }
    
    // MARK: - Update day grid
    func updateDays() {
        days = date.calendarDisplayDays
    }
    
    // MARK: - Display month and year as string
    func monthYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // MARK: - Entry checks
    func hasEntry(for day: Date) -> Bool {
        homeViewModel.entries.contains { calendar.isDate($0.date, inSameDayAs: day) }
    }
    
    func entry(for day: Date) -> DiaryEntry? {
        homeViewModel.entries.first { calendar.isDate($0.date, inSameDayAs: day) }
    }
}

// MARK: - Date extensions
extension Date {
    
    /// Default calendar
    var calendar: Calendar { Calendar.current }
    
    /// Start of day
    var startOfDay: Date { calendar.startOfDay(for: self) }
    
    /// Month as integer (1...12)
    var monthInt: Int { calendar.component(.month, from: self) }
    
    /// First letter of weekdays for header
    static var capitalizedFirstLettersOfWeekdays: [String] {
        let formatter = DateFormatter()
        formatter.locale = .current
        return formatter.shortWeekdaySymbols.map { $0.prefix(1).capitalized }
    }
    
    /// Returns 6-week grid of dates for calendar display (includes prev/next month days)
    var calendarDisplayDays: [Date] {
        // Get the start and end of the current month
        guard let monthInterval = calendar.dateInterval(of: .month, for: self),
              let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: monthInterval.start))
        else { return [] }
        
        // Start from first day of the week containing the first day of the month
        var start = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: firstDayOfMonth))!
        
        var dates: [Date] = []
        for _ in 0..<42 { // 6 weeks × 7 days
            dates.append(start)
            start = calendar.date(byAdding: .day, value: 1, to: start)!
        }
        return dates
    }
}

