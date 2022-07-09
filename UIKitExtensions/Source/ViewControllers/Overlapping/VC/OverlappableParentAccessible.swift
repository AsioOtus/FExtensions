import UIKit

public protocol OverlappableParentAccessible: UIViewController { }

public extension OverlappableParentAccessible {
	var overlappableStack: OverlappableVC? { navigationController as? OverlappableVC }
}
