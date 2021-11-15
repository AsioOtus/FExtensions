import UIKit

public protocol OverlappingViewController where Self: UIViewController {
	func prepareForHiding (_: @escaping Completion)
}

public extension OverlappingViewController {
	func prepareForHiding (_ completion: Completion) {
		completion()
	}
}
