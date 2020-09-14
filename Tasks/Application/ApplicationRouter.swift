import UIKit

protocol ApplicationRouter {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    func applicationDidEnterBackground(_ application: UIApplication)
    func setupWindow() -> UIWindow
}

class BaseApplicationRouter: NSObject, ApplicationRouter {
    private var applicationCoordinator: Coordinator?
    private let applicationDI = ApplicationDI()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func setupWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()

        window.rootViewController = navigationController
        applicationCoordinator = ApplicationCoordinator(navigationController: navigationController,
                                                        applicationDI: applicationDI)
        applicationCoordinator?.start()
        window.makeKeyAndVisible()
        return window
    }
}
