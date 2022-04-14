import UIKit

public extension UIStoryboard {
	static let main = UIStoryboard(name: "Main", bundle: nil)
}

public extension UIStoryboard {
	func instantiate <T: UIViewController> (identifier: String) -> T {
		instantiateViewController(withIdentifier: identifier) as! T
	}
	
	func instantiate <T: UIViewController> (_: T.Type) -> T {
		instantiateViewController(withIdentifier: String(describing: T.self)) as! T
	}
	
	subscript <T: UIViewController> (_: T) -> T {
		instantiate(T.self)
	}
}

public extension UIStoryboard {
	convenience init <T: StoryboardInstantiatable> (for: T.Type) { self.init(name: T.storyboardName, bundle: nil) }
	
	func instantiate <T: StoryboardInstantiatable> (identifiable: T.Type) -> T {
		instantiateViewController(withIdentifier: T.identifierInStoryboard) as! T
	}

	subscript <T: StoryboardInstantiatable> (_: T.Type) -> T {
		instantiate(T.self)
	}
}
