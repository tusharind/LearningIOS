import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SwiftUI

@main
struct SocialSignInsApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        // First, try Google Sign-In
        if GIDSignIn.sharedInstance.handle(url) {
            return true
        }

        // Then, let Firebase Auth handle any OAuth URLs (GitHub, etc.)
        if Auth.auth().canHandle(url) {
            return true
        }

        return false
    }
}
