import SwiftUI

@main
struct MyDiaryApp: App {
    
    // MARK: - ViewModels
    @StateObject private var homeVM = HomeViewModel()
    @StateObject private var settingsVM = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            // RootView handles the TabView (Home, Calendar, Settings)
            RootView()
                .environmentObject(homeVM)      // Provide HomeViewModel globally
                .environmentObject(settingsVM)  // Provide SettingsViewModel globally
        }
    }
}

