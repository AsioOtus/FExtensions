import UIKit

public class AxleView: UIView {
	private var axisX: UIView!
	private var axisY: UIView!
	
	public init (style: UIUserInterfaceStyle = .light) {
		super.init(frame: .zero)
		
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .clear
		
		createMainAxle(style)
		createSecondaryAxle(style)
	}
	
	public required init (coder: NSCoder) {
		fatalError()
	}
	
	public func insert (to view: UIView) {
		view.addSubview(self)
		
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: view.topAnchor),
			bottomAnchor.constraint(equalTo: view.bottomAnchor),
			leadingAnchor.constraint(equalTo: view.leadingAnchor),
			trailingAnchor.constraint(equalTo: view.trailingAnchor),
		])
	}
}

private extension AxleView {
	static func mainColor (_ style: UIUserInterfaceStyle) -> UIColor {
		switch style {
		case .dark:
			return .white
		default:
			return .black
		}
	}
	
	static func secondaryColor (_ style: UIUserInterfaceStyle) -> UIColor {
		switch style {
		case .dark:
			return .init(white: 1, alpha: 0.2)
		default:
			return .init(white: 0, alpha: 0.2)
		}
	}
	
	static func createAxisView (_ color: UIColor = .black) -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = color
		
		return view
	}
	
	func createMainAxisView (_ color: UIColor = .black) -> UIView {
		let view = Self.createAxisView(color)
		addSubview(view)
		
		NSLayoutConstraint.activate([
			view.centerXAnchor.constraint(equalTo: centerXAnchor),
			view.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
		
		return view
	}
	
	func createMainAxle (_ style: UIUserInterfaceStyle) {
		let color = Self.mainColor(style)
		
		axisX = createMainAxisView(color)
		axisY = createMainAxisView(color)
		
		NSLayoutConstraint.activate([
			axisX.widthAnchor.constraint(equalTo: widthAnchor),
			axisX.heightAnchor.constraint(equalToConstant: 1),
			
			axisY.widthAnchor.constraint(equalToConstant: 1),
			axisY.heightAnchor.constraint(equalTo: heightAnchor),
		])
	}
	
	func createSecondaryAxisView (_ color: UIColor = .init(white: 0, alpha: 0.2)) -> UIView {
		let view = Self.createAxisView(color)
		addSubview(view)
		view.widthAnchor.constraint(equalToConstant: 1).isActive = true
		
		return view
	}
	
	func createSecondaryAxle (_ style: UIUserInterfaceStyle) {
		let color = Self.secondaryColor(style)
		let axisStep = 50.0
		
		(0..<20).forEach { i in
			let viewX = createSecondaryAxisView(color)
			NSLayoutConstraint.activate([
				viewX.widthAnchor.constraint(equalToConstant: 1),
				viewX.heightAnchor.constraint(equalTo: heightAnchor),
				viewX.centerXAnchor.constraint(equalTo: leadingAnchor, constant: Double(i) * axisStep),
			])
			
			
			let viewY = createSecondaryAxisView(color)
			NSLayoutConstraint.activate([
				viewY.widthAnchor.constraint(equalTo: widthAnchor),
				viewY.heightAnchor.constraint(equalToConstant: 1),
				viewY.centerYAnchor.constraint(equalTo: topAnchor, constant: Double(i) * axisStep),
			])
		}
	}
}
