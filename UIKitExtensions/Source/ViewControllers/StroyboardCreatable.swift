import UIKit

public protocol StoryboardCreatable: UIViewController {
	static var storyboardName: String { get }
}

public extension StoryboardCreatable {
	static var storyboard: UIStoryboard { UIStoryboard(name: storyboardName, bundle: nil) }
	
	static func fromStoryboard () -> Self {
		storyboard.instantiateViewController(Self.self)
	}
}
