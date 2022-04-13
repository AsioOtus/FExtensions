import UIKit

public protocol StoryboardInstantiatable: UIViewController {
	static var storyboardName: String { get }
	static var storyboardIdentifier: String { get }
}

public extension StoryboardInstantiatable {
	static var storyboardName: String { String(describing: Self.self) }
	static var storyboardIdentifier: String { String(describing: Self.self) }
	
	static var storyboard: UIStoryboard { .init(name: storyboardName, bundle: .init(for: self)) }
	
	static func instantiate () -> Self {
		storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
	}
	
	static func instantiateInitial () -> Self {
		storyboard.instantiateInitialViewController() as! Self
	}
}
