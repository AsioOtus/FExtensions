import UIKit

public extension UIView {
	extension UIView {
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
	}
}
