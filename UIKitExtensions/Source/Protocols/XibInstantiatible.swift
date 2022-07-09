import UIKit

public protocol XibInstantiatable: NSObject { }

public extension XibInstantiatable {
	static var bundle: Bundle { .init(for: Self.self) }

	static var xibName: String { .init(describing: Self.self) }

	static func xib () -> UINib {
		.init(
			nibName: xibName,
			bundle: bundle
		)
	}

	static func xib (bundle: Bundle?) -> UINib {
		.init(
			nibName: xibName,
			bundle: bundle
		)
	}

	static func load (
		bundle: Bundle = bundle,
		owner: Self? = nil,
		options: [UINib.OptionsKey: Any]? = nil,
		predicate: (Any) -> Bool = { $0 is Self }
	) -> Self {
		bundle
			.loadNibNamed(
				xibName,
				owner: owner,
				options: options
			)?
			.first(where: predicate) as! Self
	}

	static func instantiate (
		bundle: Bundle?,
		owner: NSObject? = nil,
		options: [UINib.OptionsKey: Any]? = nil,
		predicate: (Any) -> Bool = { $0 is Self }
	) -> Self {
		xib(bundle: bundle)
			.instantiate(
				withOwner: owner,
				options: options
			)
			.first(where: predicate) as! Self
	}

	static func instantiate (
		owner: NSObject? = nil,
		options: [UINib.OptionsKey: Any]? = nil,
		predicate: (Any) -> Bool = { $0 is Self }
	) -> Self {
		xib(bundle: bundle)
			.instantiate(
				withOwner: owner,
				options: options
			)
			.first(where: predicate) as! Self
	}

	func instantiateView <V: UIView> (
		as type: V.Type,
		bundle: Bundle? = bundle,
		options: [UINib.OptionsKey: Any]? = nil,
		predicate: (Any) -> Bool = { $0 is V }
	) -> V {
		Self.xib(bundle: bundle)
			.instantiate(
				withOwner: self,
				options: options
			)
			.first(where: predicate) as! V
	}

	func instantiateView (
		bundle: Bundle? = bundle,
		options: [UINib.OptionsKey: Any]? = nil,
		predicate: (Any) -> Bool = { $0 is UIView }
	) -> UIView {
		Self.xib(bundle: bundle)
			.instantiate(
				withOwner: self,
				options: options
			)
			.first(where: predicate) as! UIView
	}
}
