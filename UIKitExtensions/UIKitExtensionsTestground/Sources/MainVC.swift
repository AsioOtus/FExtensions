import UIKit
import UIKitExtensions

final class Chronometer {
	private var timer: Timer?
	private(set) var seconds: Int?

	func start (_ action: @escaping (Int) -> Void) -> Void {
		let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.seconds = (self.seconds ?? 0) + 1
			self.seconds.map { action($0) }
		}

		action(0)

		self.timer = timer
	}

	func stop () -> Void {
		timer?.invalidate()
		timer = nil
		seconds = nil
	}
}

final class MainVC: UIViewController,
					StoryboardInstantiatable {
	
	static let l1: OverlappingViewContainer = {
		let view = UIView()
		view.backgroundColor = .red.withAlphaComponent(0.5)
		return .init(view)
			.set(showingAnimation: .init(duration: 0.5))
			.set(showingAnimation: { $0.add(options: .beginFromCurrentState) })
//			.set(minOverlappingInterval: 5)
	}()

	static let l2: OverlappingViewContainer = {
		let view = UIView()
		view.backgroundColor = .blue.withAlphaComponent(0.5)
		return .init(view)
//			.set(showingAnimation: .init(duration: 3))
	}()

	let c = Chronometer()

	@IBOutlet
	private var l: UILabel!

	@IBOutlet
	private var v: UIView!

	lazy var m = OverlappingViewManager(overlapped: v, overlapping: Self.l1)

	override func viewDidLoad () {
		super.viewDidLoad()

		v.addGestureRecognizer(
			UITapGestureRecognizer(target: self, action: #selector(action))
		)

		c.start { self.l.text = "\($0)" }
	}

	@objc
	func action () {
		self.m.showOverlap()

		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			self.m.showOverlap(with: Self.l2)
		}
	}
}
