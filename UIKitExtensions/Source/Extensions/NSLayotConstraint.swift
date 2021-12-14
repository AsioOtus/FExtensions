import UIKit

public extension NSLayoutConstraint {
	@discardableResult
	func active (_ value: Bool = true) -> Self {
		isActive = value
		return self
	}
}
