import UIKit

public protocol TypifyView: UIViewController {
	associatedtype RootView: UIView
	
	var rootView: RootView { get }
}

public extension TypifyView {
	var rootView: RootView { view as! RootView }
}
