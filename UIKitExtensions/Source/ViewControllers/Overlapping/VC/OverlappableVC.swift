import UIKit

public protocol OverlappableVC: UIViewController, Overlappable, OverlappedViewProvider {
	var overlappingVC: OverlappingVC { get }
}

public extension OverlappableVC {
	var overlappedView: UIView { view }

	func showOverlap (completion: @escaping () -> Void = { }) {
		overlappingVC.onOverlapShowingStart {
			DispatchQueue.main.async {
				guard !self.children.contains(where: { $0 === self.overlappingVC }) else {
					completion()
					self.overlappingVC.onOverlapShowingEnd()

					self.overlappingVC.showingTimestamp = nil
					return
				}

				self.overlappingVC.showingTimestamp = .now()

				self.addChild(self.overlappingVC)
				self.overlappedView.insertFullframe(self.overlappingVC.view)

				UIView.transition(
					with: self.overlappedView,
					duration: self.overlappingVC.showingAnimation.duration,
					options: self.overlappingVC.showingAnimation.options,
					animations: self.overlappingVC.showingAnimation.animation,
					completion: { _ in
						self.overlappingVC.didMove(toParent: self)
						completion()
						self.overlappingVC.onOverlapShowingEnd()
					}
				)
			}
		}
	}

	func hideOverlap (completion: @escaping () -> Void = { }) {
		overlappingVC.onOverlapHidingStart {
			DispatchQueue.main.asyncAfter(deadline: self.overlappingVC.minHidingTimestamp) {
				guard self.children.contains(where: { $0 === self.overlappingVC }) else {
					completion()
					self.overlappingVC.onOverlapHidingEnd()

					self.overlappingVC.showingTimestamp = nil
					return
				}

				UIView.transition(
					with: self.overlappedView,
					duration: self.overlappingVC.hidingAnimation.duration,
					options: self.overlappingVC.hidingAnimation.options,
					animations: {
						self.overlappingVC.removeFromHierarchy {
							self.overlappingVC.hidingAnimation.animation()
						}
					},
					completion: { _ in
						completion()
						self.overlappingVC.onOverlapHidingEnd()

						self.overlappingVC.showingTimestamp = nil
					}
				)
			}
		}
	}
}
