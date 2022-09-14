import UIKit

public final class OverlappingViewManager: Overlapping, OverlappingDelegate {
	private let _overlappableView: UIView
	private var _overlappingView: UIView

	private var overlappedView: UIView {
		if let overlappableView = _overlappableView as? OverlappableView {
			return overlappableView.overlappedView
		} else {
			return _overlappableView
		}
	}

	private var _overlapping: Overlapping? { _overlappingView as? Overlapping }
	private var _overlappingDelegate: OverlappingDelegate { (_overlappingView as? OverlappingDelegate) ?? self }
	private var _selfOverlapping: Overlapping { self as Overlapping }

	private var _showingTimestamp: DispatchTime?
	public var showingTimestamp: DispatchTime? {
		get { _overlapping?.showingTimestamp ?? _showingTimestamp }
		set {
			if _overlapping != nil {
				_overlapping?.showingTimestamp = newValue
			} else {
				_showingTimestamp = newValue
			}
		}
	}

	private var _minHidingTimestamp: DispatchTime?
	public var minHidingTimestamp: DispatchTime? {
		get {
			_minHidingTimestamp ??
			_overlapping?.minHidingTimestamp ??
			_selfOverlapping.minHidingTimestamp
		}
		set {
			_minHidingTimestamp = newValue
		}
	}

	private var _minOverlappingInterval: Double?
	public var minOverlappingInterval: Double {
		get {
			_minOverlappingInterval ??
			_overlapping?.minOverlappingInterval ??
			_selfOverlapping.minOverlappingInterval
		}
		set {
			_minOverlappingInterval = newValue
		}
	}

	private var _showingAnimation: Animation?
	public var showingAnimation: Animation {
		get {
			_showingAnimation ??
			_overlapping?.showingAnimation ??
			_selfOverlapping.showingAnimation
		}
		set {
			_showingAnimation = newValue
		}
	}

	private var _hidingAnimation: Animation?
	public var hidingAnimation: Animation {
		get {
			_hidingAnimation ??
			_overlapping?.hidingAnimation ??
			_selfOverlapping.hidingAnimation
		}
		set {
			_hidingAnimation = newValue
		}
	}

	public init (overlapped: UIView, overlapping: OverlappingView) {
		_overlappableView = overlapped
		_overlappingView = overlapping
	}
}

public extension OverlappingViewManager {
	@discardableResult
	func set (minHidingTimestamp: DispatchTime) -> Self {
		self.minHidingTimestamp = minHidingTimestamp
		return self
	}

	@discardableResult
	func set (minOverlappingInterval: Double) -> Self {
		self.minOverlappingInterval = minOverlappingInterval
		return self
	}

	@discardableResult
	func set (showingAnimation: (Animation) -> Animation) -> Self {
		self.showingAnimation = showingAnimation(self.showingAnimation)
		return self
	}

	@discardableResult
	func set (hidingAnimation: (Animation) -> Animation) -> Self {
		self.hidingAnimation = hidingAnimation(self.hidingAnimation)
		return self
	}

	@discardableResult
	func set (showingAnimation: Animation) -> Self {
		self.showingAnimation = showingAnimation
		return self
	}

	@discardableResult
	func set (hidingAnimation: Animation) -> Self {
		self.hidingAnimation = hidingAnimation
		return self
	}
}

extension OverlappingViewManager: Overlappable {
	public func showOverlap (completion: @escaping () -> Void = { }) {
		_overlappingDelegate.onOverlapShowingStart {
			DispatchQueue.main.async {
				guard !self.overlappedView.subviews.contains(where: { $0 === self._overlappingView }) else {
					completion()
					self._overlappingDelegate.onOverlapShowingEnd()

					self.showingTimestamp = nil
					return
				}

				self.showingTimestamp = .now()

				self.overlappedView.insertFullframe(self._overlappingView)

				UIView.transition(
					with: self.overlappedView,
					duration: self.showingAnimation.duration,
					options: self.showingAnimation.options,
					animations: self.showingAnimation.animation,
					completion: { _ in
						completion()
						self._overlappingDelegate.onOverlapShowingEnd()
					}
				)
			}
		}
	}

	public func hideOverlap (completion: @escaping () -> Void = { }) {
		_overlappingDelegate.onOverlapHidingStart {
			DispatchQueue.main.asyncAfter(deadline: self.minHidingTimestamp) {
				guard self.overlappedView.subviews.contains(where: { $0 === self._overlappingView }) else {
					completion()
					self._overlappingDelegate.onOverlapHidingEnd()

					self.showingTimestamp = nil
					return
				}

				UIView.transition(
					with: self.overlappedView,
					duration: self.hidingAnimation.duration,
					options: self.hidingAnimation.options,
					animations: {
						self._overlappingView.removeFromSuperview()
						self.hidingAnimation.animation()
					},
					completion: { _ in
						completion()
						self._overlappingDelegate.onOverlapHidingEnd()

						self.showingTimestamp = nil
					}
				)
			}
		}
	}
}

public extension OverlappingViewManager {
	func showOverlap (with overlapping: OverlappingView, completion: @escaping () -> Void = { }) {
		guard overlapping !== self._overlappingView else { return }

		hideOverlap {
			self._overlappingView = overlapping
			self.showOverlap(completion: completion)
		}
	}

	func overlappedAction (with overlapping: OverlappingView, action: @escaping (@escaping ((@escaping () -> Void) -> Void)) -> Void) {
		guard overlapping !== self._overlappingView else { return }

		hideOverlap {
			self._overlappingView = overlapping
			self.showOverlap {
				action { completion in
					self.hideOverlap(completion: completion)
				}
			}
		}
	}

	func overlappedActionImmediately (with overlapping: OverlappingView, action: @escaping (() -> Void) -> Void, completion: @escaping () -> Void = { }) {
		guard overlapping !== self._overlappingView else { return }

		hideOverlap {
			self._overlappingView = overlapping
			self.showOverlap { }

			action {
				self.hideOverlap(completion: completion)
			}
		}
	}
}
