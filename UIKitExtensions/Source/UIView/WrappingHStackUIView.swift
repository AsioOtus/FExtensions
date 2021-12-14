import UIKit

public class WrappingHStackUIView: UIView {
	private var views = [UIView]()
	
	private let lineHeight: Double
	private let spacingX: Double
	private let spacingY: Double
	
	private var heightConstaint = NSLayoutConstraint()
	
	public init (_ views: [UIView], lineHeight: Double, spacingX: Double = 10, spacingY: Double = 10) {
		self.views = views
		
		self.lineHeight = lineHeight
		self.spacingX = spacingX
		self.spacingY = spacingY
		
		super.init(frame: .zero)
		
		heightConstaint = heightAnchor.constraint(equalToConstant: 0)
		heightConstaint.isActive = true
		
		translatesAutoresizingMaskIntoConstraints = false
		//		setContentHuggingPriority(.required, for: .vertical)
		//		setContentHuggingPriority(.required, for: .horizontal)
		
		integrateView()
	}
	
	public required init? (coder: NSCoder) {
		fatalError()
	}
	
	public override func layoutSubviews () {
		super.layoutSubviews()
		
		displayViews()
	}
}

private extension WrappingHStackUIView {
	func integrateView () {
		views.forEach { view in
			view.translatesAutoresizingMaskIntoConstraints = false
			addSubview(view)
		}
	}
	
	func displayViews () {
		let width = frame.width
		
		var currentOriginX: CGFloat = 0
		var currentOriginY: CGFloat = 0
		
		views.forEach { view in
			if currentOriginX + view.frame.width > width {
				currentOriginX = 0
				currentOriginY += lineHeight + spacingY
			}
			
			view.frame.origin.x = currentOriginX
			view.frame.origin.y = currentOriginY
			
			currentOriginX += view.frame.width + spacingX
		}
		
		heightConstaint.constant = currentOriginY + lineHeight
	}
}
