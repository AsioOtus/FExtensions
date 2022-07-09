import UIKit

public final class OverlappingViewContainer <ContentView: UIView>: UIView, OverlappingView {
	public let contentView: ContentView
	public var showingTimestamp: DispatchTime?

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

public protocol OverlappingContainerViewContent: UIView { }

public extension OverlappingContainerViewContent {
	func overlapping () -> OverlappingViewContainer<Self> { .init(self) }
}
