public protocol OverlappingDelegate: AnyObject {
	func onOverlapShowingStart (completion: @escaping () -> Void)
	func onOverlapShowingEnd (completion: @escaping () -> Void)
	func onOverlapHidingStart (completion: @escaping () -> Void)
	func onOverlapHidingEnd (completion: @escaping () -> Void)
}

public extension OverlappingDelegate {
	func onOverlapShowingStart (completion: @escaping () -> Void) { completion() }
	func onOverlapShowingEnd (completion: @escaping () -> Void = { }) { completion() }
	func onOverlapHidingStart (completion: @escaping () -> Void) { completion() }
	func onOverlapHidingEnd (completion: @escaping () -> Void = { }) { completion() }
}
