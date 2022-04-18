import UIKit

public protocol TypifiableRootView: UIViewController {
	associatedtype RootView: UIView
	
	var rootView: RootView { get }
}

public extension TypifiableRootView {
	var rootView: RootView { view as! RootView }
}
