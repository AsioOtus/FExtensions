import UIKit

public final class OverlappingViewManager {
	private let overlappableView: UIView
	private var overlappingView: OverlappingView

	private var overlappedView: UIView {
		if let overlappableView = overlappableView as? OverlappableView {
			return overlappableView.overlappedView
		} else {
			return overlappableView
		}
	}

	public init (overlapped: UIView, overlapping: OverlappingView) {
		overlappableView = overlapped
		overlappingView = overlapping
	}
}

extension OverlappingViewManager: Overlappable {
	public func showOverlap (completion: @escaping () -> Void = { }) {
		overlappingView.onOverlapShowingStart {
			DispatchQueue.main.async {
				guard !self.overlappedView.subviews.contains(where: { $0 === self.overlappingView }) else {
					completion()
					self.overlappingView.onOverlapShowingEnd()

					self.overlappingView.showingTimestamp = nil
					return
				}

				self.overlappingView.showingTimestamp = .now()

				self.overlappedView.insertFullframe(self.overlappingView)

				UIView.transition(
					with: self.overlappedView,
					duration: self.overlappingView.showingAnimation.duration,
					options: self.overlappingView.showingAnimation.options,
					animations: self.overlappingView.showingAnimation.animation,
					completion: { _ in
						completion()
						self.overlappingView.onOverlapShowingEnd()
					}
				)
			}
		}
	}

	public func hideOverlap (completion: @escaping () -> Void = { }) {
		overlappingView.onOverlapHidingStart {
			DispatchQueue.main.asyncAfter(deadline: self.overlappingView.minHidingTimestamp) {
				guard self.overlappedView.subviews.contains(where: { $0 === self.overlappingView }) else {
					completion()
					self.overlappingView.onOverlapHidingEnd()

					self.overlappingView.showingTimestamp = nil
					return
				}

				UIView.transition(
					with: self.overlappedView,
					duration: self.overlappingView.hidingAnimation.duration,
					options: self.overlappingView.hidingAnimation.options,
					animations: {
						self.overlappingView.removeFromSuperview()
						self.overlappingView.hidingAnimation.animation()
					},
					completion: { _ in
						completion()
						self.overlappingView.onOverlapHidingEnd()

						self.overlappingView.showingTimestamp = nil
					}
				)
			}
		}
	}
}

public extension OverlappingViewManager {
	func showOverlap (with overlapping: OverlappingView, completion: @escaping () -> Void = { }) {
		hideOverlap {
			self.overlappingView = overlapping
			self.showOverlap(completion: completion)
		}
	}

	func overlappedAction (with overlapping: OverlappingView, action: @escaping (@escaping ((@escaping () -> Void) -> Void)) -> Void) {
		hideOverlap {
			self.overlappingView = overlapping
			self.showOverlap {
				action { completion in
					self.hideOverlap(completion: completion)
				}
			}
		}
	}

	func overlappedActionImmediately (with overlapping: OverlappingView, action: @escaping (() -> Void) -> Void, completion: @escaping () -> Void = { }) {
		hideOverlap {
			self.overlappingView = overlapping
			self.showOverlap { }

			action {
				self.hideOverlap(completion: completion)
			}
		}
	}
}
