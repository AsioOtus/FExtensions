import UIKit

public typealias ColorVC = ColorViewController

open class ColorViewController: UIViewController {
	private let backgroundColor: UIColor
	private let foregroundColor: UIColor
	private let name: String
	private let action: () -> Void
	
	private let actionButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitle("Action", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		return button
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .systemFont(ofSize: 24)
		return label
	}()
	
	public init (name: String = "", backgroundColor: UIColor, foregroundColor: UIColor = .black, action: @escaping () -> Void = { }) {
		self.backgroundColor = backgroundColor.new(alpha: 0.5)
		self.foregroundColor = foregroundColor
		self.name = name
		self.action = action
		
		super.init(nibName: nil, bundle: nil)
	}
	
	public required init? (coder: NSCoder) { fatalError() }
	
	public override func viewDidLoad () {
		super.viewDidLoad()
	
		setupView()
		
		addActionButton()
		addNameLabel()
	}
}

private extension ColorVC {
	func setupView () {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = backgroundColor
	}
	
	func addActionButton () {
		actionButton.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
		
		view.addSubview(actionButton)
		
		NSLayoutConstraint.activate([
			actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
	func addNameLabel () {
		nameLabel.text = name
		nameLabel.textColor = foregroundColor
		nameLabel.sizeToFit()
		
		view.addSubview(nameLabel)
		
		NSLayoutConstraint.activate([
			nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			nameLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16)
		])
	}
}

private extension ColorVC {
	@objc func buttonTapped () { action() }
}
