import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        
        // Your root view controller (for example, ContactListViewController)
        let rootVC = ContactListViewController()
        let navVC = UINavigationController(rootViewController: rootVC)
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        
        self.window = window
    }

    
}

