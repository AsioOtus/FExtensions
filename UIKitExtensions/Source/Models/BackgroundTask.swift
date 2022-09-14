import UIKit

public class BackgroundTask {
	private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
	
	public init () { }
	
	public func start () {
		backgroundTask = UIApplication.shared.beginBackgroundTask {
			self.end()
		}
	}
	
	public func end () {
		UIApplication.shared.endBackgroundTask(backgroundTask)
		backgroundTask = .invalid
	}
	
	public func restart () {
		if backgroundTask == .invalid {
			start()
		}
	}
}
