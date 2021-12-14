import UIKit

public extension UIStoryboard {
	static let main = UIStoryboard(name: "Main", bundle: nil)
}

public extension UIStoryboard {
	func instantiateViewController <T: UIViewController> (_ storyboardIdentifier: String) -> T {
		instantiateViewController(withIdentifier: storyboardIdentifier) as! T
	}
	
	func instantiateViewController <T: UIViewController> (_ type: T.Type) -> T {
		instantiateViewController(withIdentifier: String(describing: type.self)) as! T
	}
	
	subscript <T: UIViewController> (_ type: T.Type) -> T {
		instantiateViewController(type)
	}
}
