import UIKit

public protocol XibCreatable: UIViewController {
	static var xibName: String { get }
	
	static func fromXib () -> Self 
}

public extension XibCreatable {
	static var xibName: String { String(describing: Self.self) }
	
	static func fromXib () -> Self {
		Self.init(nibName: xibName, bundle: nil)
	}
}
