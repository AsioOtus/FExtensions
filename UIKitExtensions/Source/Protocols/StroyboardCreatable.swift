import UIKit

public protocol StoryboardCreatable: UIViewController {
	static var storyboardName: String { get }
}

public extension StoryboardCreatable {
	static var storyboardIdentifier: String { String(describing: Self.self) }
	static var storyboard: UIStoryboard { UIStoryboard(name: storyboardName, bundle: nil) }
	
	static func fromStoryboard () -> Self {
		storyboard.instantiateViewController(storyboardIdentifier)
	}
}
