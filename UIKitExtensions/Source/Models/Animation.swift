import UIKit

public struct Animation {
	public let duration: Double
	public let options: UIView.AnimationOptions
	public let animation: () -> Void
	
	public init (
		duration: Double = 1,
		options: UIView.AnimationOptions = [
			.transitionCrossDissolve,
			.allowUserInteraction,
			.allowAnimatedContent,
			.beginFromCurrentState
		],
		animation: @escaping () -> Void = { }
	) {
		self.duration = duration
		self.options = options
		self.animation = animation
	}
}

public extension Animation {
	func set (duration: Double) -> Self {
		.init(duration: duration, options: options, animation: animation)
	}

	func set (options: UIView.AnimationOptions) -> Self {
		.init(duration: duration, options: options, animation: animation)
	}

	func add (options: UIView.AnimationOptions) -> Self {
		.init(duration: duration, options: self.options.union(options), animation: animation)
	}

	func set (animation: @escaping () -> Void) -> Self {
		.init(duration: duration, options: options, animation: animation)
	}
}
