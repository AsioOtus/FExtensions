import UIKit

public final class OverlappingViewContainer <ContentView: UIView>: UIView, OverlappingView {
	public let contentView: ContentView
	public var showingTimestamp: DispatchTime?

	public var minOverlappingInterval: Double = 0

	public var showingAnimation: Animation = .init(duration: 0.5)
	public var hidingAnimation: Animation = .init(duration: 0.5)

	public init (_ contentView: ContentView) {
		self.contentView = contentView

		super.init()

		insertFullframe(contentView)
	}

	required init? (coder: NSCoder) {
		contentView = .init()

		super.init(coder: coder)
	}

	override public init (frame: CGRect) {
		contentView = .init()

		super.init(frame: frame)
	}
}

public extension OverlappingViewContainer {
	@discardableResult
	func set (minOverlappingInterval: Double) -> Self {
		self.minOverlappingInterval = minOverlappingInterval
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
}

public protocol OverlappingContainerViewContent: UIView { }

public extension OverlappingContainerViewContent {
	func overlapping () -> OverlappingViewContainer<Self> { .init(self) }
}
