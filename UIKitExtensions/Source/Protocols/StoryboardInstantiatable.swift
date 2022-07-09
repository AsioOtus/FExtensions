import UIKit

public protocol StoryboardInstantiatable: UIViewController { }

public extension StoryboardInstantiatable {
	static var storyboardName: String { .init(describing: Self.self) }
	static var identifierInStoryboard: String { .init(describing: Self.self) }

	static var storyboard: UIStoryboard { .init(name: storyboardName, bundle: .init(for: self)) }

	static func instantiate (from storyboard: UIStoryboard = storyboard) -> Self {
		storyboard
			.instantiateViewController(
				withIdentifier: identifierInStoryboard
			) as! Self
	}

	static func instantiateInitial (from storyboard: UIStoryboard = storyboard) -> Self {
		storyboard
			.instantiateInitialViewController() as! Self
	}
}
