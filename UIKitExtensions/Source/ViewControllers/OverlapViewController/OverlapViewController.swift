import UIKit

public class OverlapViewController: UIViewController {
	private(set) var minOverlapInterval: Double = 0
	
	public var overlapDisplayAnimation = Animation(duration: 0.5)
	public var overlapHideAnimation = Animation(duration: 0.5)
	
	public weak var overlappedVC: OverlappedViewController? {
		willSet {
			guard let overlappedVC = overlappedVC else { return }
			
			DispatchQueue.main.async {
				overlappedVC.willMove(toParent: nil)
				overlappedVC.view.removeFromSuperview()
				overlappedVC.removeFromParent()
			}
			
			overlappedVC.overlapVC = nil
		}
		didSet {
			guard let overlappedVC = overlappedVC else { return }
			
			self.insertFullframeChild(overlappedVC, index: 0)
			
			overlappedVC.overlapVC = self
		}
	}
	
	public var overlappingVC: OverlappingViewController?
	
	public var isOverlapping: Bool {
		guard let overlappingVC = overlappingVC else { return false }
		return children.contains(overlappingVC)
	}
}

public extension OverlapViewController {
	static func create (
		overlappedVC: OverlappedViewController? = nil,
		overlappingVC: OverlappingViewController? = nil,
		minOverlapInterval: Double = 0,
		animation: Animation = .init(duration: 0.5)
	) -> Self {
		let overlapVC = Self()
		
		overlapVC.overlappedVC = overlappedVC
		overlapVC.overlappingVC = overlappingVC
		
		overlapVC.minOverlapInterval = minOverlapInterval
		
		overlapVC.overlapDisplayAnimation = animation
		overlapVC.overlapHideAnimation = animation
		
		return overlapVC
	}
}

public extension OverlapViewController {
	func displayOverlap (_ completion: Completion? = nil) {
		guard let overlapVC = overlappingVC else { return }
		
		DispatchQueue.main.async {
			self.addChild(overlapVC)
			self.view.addSubview(overlapVC.view)
			overlapVC.view.pinBounds(to: self.view)
			
			UIView.transition(
				with: self.view,
				duration: self.overlapDisplayAnimation.duration,
				options: self.overlapDisplayAnimation.options,
				animations: self.overlapDisplayAnimation.animation,
				completion: { _ in
					overlapVC.didMove(toParent: self)
					completion?()
				}
			)
		}
	}
	
	func hideOverlap (_ completion: Completion? = nil) {
		guard let overlappingVC = overlappingVC else { return }
		
		DispatchQueue.main.asyncAfter(deadline: .now() + minOverlapInterval) {
			overlappingVC.prepareForHiding { [weak overlappingVC, weak self] in
				guard let self = self else { return }
				
				UIView.transition(
					with: self.view,
					duration: self.overlapHideAnimation.duration,
					options: self.overlapHideAnimation.options,
					animations: {
						overlappingVC?.willMove(toParent: nil)
						
						self.overlapHideAnimation.animation()
						
						overlappingVC?.view.removeFromSuperview()
						overlappingVC?.removeFromParent()
					},
					completion: { _ in
						completion?()
					}
				)
			}
		}
	}
}

public extension OverlapViewController {
	func action (_ action: @escaping (@escaping Completion) -> Void, _ completion: Completion? = nil) {
		displayOverlap {
			action {
				self.hideOverlap(completion)
			}
		}
	}
	
	func actionImmediately (_ action: @escaping (Completion) -> Void, _ completion: Completion? = nil) {
		displayOverlap()
		action {
			self.hideOverlap(completion)
		}
	}
	
	func replaceOverlapped (_ vc: OverlappedViewController, _ completion: Completion? = nil) {
		displayOverlap {
			self.overlappedVC = vc
			self.hideOverlap(completion)
		}
	}
}
