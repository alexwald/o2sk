import UIKit

#if DEBUG
import Atlantis
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var dependencies: CardDependencies = {
        CardDependencies(host: Config.serverURL)
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
    Atlantis.start()
#endif

        window = UIWindow()
        let navigationVC = UINavigationController(rootViewController: CardViewController(dependencies: dependencies))

        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
