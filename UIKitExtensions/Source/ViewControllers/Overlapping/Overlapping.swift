import UIKit

public protocol Overlapping: AnyObject {
	var showingTimestamp: DispatchTime? { get set }
	var minHidingTimestamp: DispatchTime { get }

	var minOverlappingInterval: Double { get }

	var showingAnimation: Animation { get }
	var hidingAnimation: Animation { get }
}

public extension Overlapping {
	var minHidingTimestamp: DispatchTime { showingTimestamp.map { $0 + minOverlappingInterval } ?? .init(uptimeNanoseconds: 0) }

	var minOverlappingInterval: Double { 0 }

	var showingAnimation: Animation { .init(duration: 0.5) }
	var hidingAnimation: Animation { .init(duration: 0.5) }
}
