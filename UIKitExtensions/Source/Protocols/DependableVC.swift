import UIKit

public protocol DependableVC: UIViewController {
	associatedtype Dependencies

	var dependencies: Dependencies? { get set }

	func set (dependencies: Dependencies) -> Self
}

public extension DependableVC {
	var d: Dependencies! { dependencies }

	func set (dependencies: Dependencies) -> Self {
		self.dependencies = dependencies
		return self
	}
}
