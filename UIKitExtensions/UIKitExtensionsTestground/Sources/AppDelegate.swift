import UIKit
import UIKitExtensions

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let window = UIWindow()
		
		window.rootViewController = ColorVC(name: "Root VC", backgroundColor: .red, foregroundColor: .white) { print("Root VC – Action button pressed") }
		
		self.window = window
		window.makeKeyAndVisible()
		
		return true
	}
}
