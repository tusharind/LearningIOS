import SwiftUI

@main
struct MyGalleryApp: App {
    init() {
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            MemoryListView()
        }
    }
}

