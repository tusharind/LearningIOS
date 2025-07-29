import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(framea: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ContactListViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

