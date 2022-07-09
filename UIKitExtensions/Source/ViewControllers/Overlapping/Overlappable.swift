public protocol Overlappable {
	func showOverlap (completion: @escaping () -> Void)
	func hideOverlap (completion: @escaping () -> Void)
	func overlappedAction (action: @escaping (@escaping ((@escaping () -> Void) -> Void)) -> Void)
	func overlappedActionImmediately (action: @escaping (() -> Void) -> Void, completion: @escaping () -> Void)
}

public extension Overlappable {
	func overlappedAction (action: @escaping (@escaping ((@escaping () -> Void) -> Void)) -> Void) {
		showOverlap {
			action { completion in
				self.hideOverlap(completion: completion)
			}
		}
	}

	func overlappedActionImmediately (action: @escaping (() -> Void) -> Void, completion: @escaping () -> Void = { }) {
		showOverlap { }
		action {
			self.hideOverlap(completion: completion)
		}
	}
}
