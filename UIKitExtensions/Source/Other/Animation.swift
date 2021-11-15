import UIKit

public struct Animation {
	public let duration: Double
	public let options: UIView.AnimationOptions
	public let animation: () -> ()
	
	public init (duration: Double = 1, options: UIView.AnimationOptions = [.transitionCrossDissolve, .allowUserInteraction, .allowAnimatedContent], animation: @escaping () -> () = { }) {
		self.duration = duration
		self.options = options
		self.animation = animation
	}
}
