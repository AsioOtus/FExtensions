import UIKit

public extension UIView {
	func pinBounds (to view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: view.topAnchor),
			bottomAnchor.constraint(equalTo: view.bottomAnchor),
			leadingAnchor.constraint(equalTo: view.leadingAnchor),
			trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
}
