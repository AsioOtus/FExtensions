import UIKit

public class WrappingHStackViewController: UIViewController {
	private var items = [UIViewController]()
	
	private let lineHeight: Double
	private let spacingX: Double
	private let spacingY: Double
	
	public init (_ items: [UIViewController], lineHeight: Double, spacingX: Double = 8, spacingY: Double = 8) {
		self.lineHeight = lineHeight
		self.spacingX = spacingX
		self.spacingY = spacingY
		
		self.items = items
		
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init? (coder: NSCoder) {
		fatalError()
	}
	
	public	override func viewDidLoad() {
		super.viewDidLoad()
		
		if #available(iOS 11, *) {
			_ = view.safeAreaLayoutGuide // Magic call, do not remove
		}
		
		integrateItems()
	}
	
	public override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		displayItems()
	}
}

public extension WrappingHStackViewController {
	func integrateItems () {
		items.forEach { vc in
			guard let newView = vc.view else { return }
			
			addChild(vc)
			view.addSubview(newView)
			vc.didMove(toParent: self)
			
			newView.translatesAutoresizingMaskIntoConstraints = false
			newView.backgroundColor = .clear
		}
	}
	
	func displayItems () {
		let viewWidth = view.frame.size.width
		
		var currentOriginX: CGFloat = 0
		var currentOriginY: CGFloat = 0
		
		items.forEach { vc in
			guard let vcView = vc.view else { return }
			
			if currentOriginX + vcView.frame.width > viewWidth {
				currentOriginX = 0
				currentOriginY += lineHeight + spacingY
			}
			
			vcView.frame.origin.x = currentOriginX
			vcView.frame.origin.y = currentOriginY
			
			currentOriginX += vcView.frame.width + spacingX
		}
		
		currentOriginY += lineHeight + spacingY
	}
}
