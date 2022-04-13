import UIKit

public extension UIStoryboard {
	static let main = UIStoryboard(name: "Main", bundle: nil)
}

public extension UIStoryboard {
	func instantiateViewController <T: UIViewController> (_ storyboardIdentifier: String) -> T {
		instantiateViewController(withIdentifier: storyboardIdentifier) as! T
	}
	
	func instantiateViewController <T: UIViewController> (_: T.Type) -> T {
		instantiateViewController(withIdentifier: String(describing: T.self)) as! T
	}
	
	subscript <T: UIViewController> (_: T) -> T {
		instantiateViewController(T.self)
	}
}

public extension UIStoryboard {
	func instantiateViewController <T: StoryboardInstantiatable> (_: T.Type) -> T {
		instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
	}

	subscript <T: StoryboardInstantiatable> (_: T.Type) -> T {
		instantiateViewController(T.self)
	}
}
