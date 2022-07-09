import UIKit

public protocol OverlappableView: UIView, Overlappable, OverlappedViewProvider {
	var overlappingView: OverlappingView { get }
}

public extension OverlappableView {
	var overlappedView: UIView { self }

	func showOverlap (completion: @escaping () -> Void = { }) {
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

	func hideOverlap (completion: @escaping () -> Void = { }) {
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
