import UIKit

public protocol TypifyRootView: UIViewController {
	associatedtype RootView: UIView
	
	var rootView: RootView { get }
}

public extension TypifyRootView {
	var rootView: RootView { view as! RootView }
}
