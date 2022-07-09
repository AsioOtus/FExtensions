import UIKit

public final class OverlappingVCContainer <ContentVC: UIViewController>: UIViewController, OverlappingVC {
	public let contentVC: ContentVC
	public var showingTimestamp: DispatchTime?

	public init (_ contentVC: ContentVC) {
		self.contentVC = contentVC

		super.init()
	}

	required init? (coder: NSCoder) {
		contentVC = .init()

		super.init(coder: coder)
	}

	override init (nibName: String?, bundle: Bundle?) {
		contentVC = .init()

		super.init(nibName: nibName, bundle: bundle)
	}

	public override func viewDidLoad () {
		super.viewDidLoad()

		insertFullframeChild(contentVC)
	}
}

public protocol OverlappingContainerVCContent: UIViewController { }

public extension OverlappingContainerVCContent {
	func overlapping () -> OverlappingVCContainer<Self> { .init(self) }
}
