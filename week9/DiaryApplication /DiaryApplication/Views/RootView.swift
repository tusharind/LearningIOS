import SwiftUI

/// Root view of the Diary app containing tabs for Home, Calendar, and Settings
struct RootView: View {
    
    // MARK: - StateObjects
    @StateObject private var homeVM:HomeViewModel     // Home tab data
    @StateObject private var settingsVM = SettingsViewModel() // Settings tab data
    @StateObject private var calendarVM:CalendarViewModel
    @ObservedObject private var preferences = PreferencesStore.shared // Global preferences
    
    init() {
           let homeVM = HomeViewModel()
           _homeVM = StateObject(wrappedValue: homeVM)
           _calendarVM = StateObject(wrappedValue: CalendarViewModel(homeViewModel: homeVM))
       }
    
    // MARK: - Body
    var body: some View {
        TabView {
            
            // Home tab
            HomeView()
                .environmentObject(homeVM)
                .tabItem { Label("Home", systemImage: "house") }
            
            // Calendar tab
            CalendarView(viewModel: calendarVM)
                .tabItem { Label("Calendar", systemImage: "calendar") }
            
            // Settings tab
            SettingsView()
                .environmentObject(settingsVM)
                .tabItem { Label("Settings", systemImage: "gear") }
            
            NavigationView {
                    InspireView()
                }
                .tabItem { Label("Inspire", systemImage: "sparkles") }
        }
        // Apply dark mode based on preferences
        .preferredColorScheme(preferences.darkModeEnabled ? .dark : .light)
    }
}

