import UIKit

public extension UIView {
	@discardableResult
	func squared () -> Self {
		self.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		return self
	}
	
	@discardableResult
	func aspectRatio (_ value: Double) -> Self {
		self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: value).isActive = true
		return self
	}
	
	@discardableResult
	func centered (in view: UIView) -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			centerXAnchor.constraint(equalTo: view.centerXAnchor),
			centerYAnchor.constraint(equalTo: view.centerYAnchor),
		])
		
		return self
	}
	
	@discardableResult
	func pinBounds (to view: UIView) -> Self {
		translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: view.topAnchor),
			bottomAnchor.constraint(equalTo: view.bottomAnchor),
			leadingAnchor.constraint(equalTo: view.leadingAnchor),
			trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		return self
	}

	@discardableResult
	func insertFullframe (_ view: UIView, at index: Int? = nil) -> Self {
		if let index = index {
			insertSubview(view, at: index)
		} else {
			addSubview(view)
		}

		view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor)
		])

		return self
	}
}

public extension UIView {
	@IBInspectable
	var cornerRadius: CGFloat {
		get { layer.cornerRadius }
		set { layer.cornerRadius = newValue  }
	}

	@discardableResult
	func cornerRadius (_ value: CGFloat) -> Self {
		layer.cornerRadius = value
		return self
	}
}
