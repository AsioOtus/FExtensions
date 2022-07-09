import UIKit

public extension UIViewController {
	func insertFullframeChild (
		_ childVC: UIViewController,
		index: Int? = 0
	) {
		DispatchQueue.main.async {
			self.addChild(childVC)
			if let index = index {
				self.view.insertSubview(childVC.view, at: index)
			} else {
				self.view.addSubview(childVC.view)
			}
			childVC.view.pinBounds(to: self.view)
			childVC.didMove(toParent: self)
		}
	}

	func insertFullframeChild (
		_ childVC: UIViewController,
		to view: UIView,
		index: Int? = 0
	) {
		DispatchQueue.main.async {
			self.addChild(childVC)
			if let index = index {
				view.insertSubview(childVC.view, at: index)
			} else {
				view.addSubview(childVC.view)
			}
			childVC.view.pinBounds(to: view)
			childVC.didMove(toParent: self)
		}
	}

	func removeFromHierarchy (_ action: () -> Void = { }) {
		willMove(toParent: nil)
		action()
		view.removeFromSuperview()
		removeFromParent()
	}
}
