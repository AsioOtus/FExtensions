import UIKit

public class TypifyOverlapViewController<OverlappingVC: OverlappingViewController>: OverlapViewController {
	public var typifyOverlappingVC: OverlappingVC? {
		get { overlappingVC as? OverlappingVC }
		set { overlappingVC = newValue }
	}
}
