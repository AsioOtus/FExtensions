import UIKit

public extension UIViewController {
	func insertFullframeChild (
		_ childVC: UIViewController,
		_ view: UIView? = nil,
		index: Int = 0
	) {
		DispatchQueue.main.async {
			let containerView: UIView = view ?? self.view
			
			self.addChild(childVC)
			containerView.insertSubview(childVC.view, at: index)
			containerView.pinBounds(to: childVC.view)
			childVC.didMove(toParent: self)
		}
	}
}
