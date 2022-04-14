import UIKit

public protocol StoryboardInstantiatable: UIViewController {
	static var storyboardName: String { get }
	static var identifierInStoryboard: String { get }
}

public extension StoryboardInstantiatable {
	static var storyboardName: String { String(describing: Self.self) }
	static var identifierInStoryboard: String { String(describing: Self.self) }
	
	static var storyboard: UIStoryboard { .init(name: storyboardName, bundle: .init(for: self)) }
	
	static func instantiate () -> Self {
		storyboard.instantiateViewController(withIdentifier: identifierInStoryboard) as! Self
	}
	
	static func instantiateInitial () -> Self {
		storyboard.instantiateInitialViewController() as! Self
	}
}
