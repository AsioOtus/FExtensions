import SwiftUI

public struct EqualWidthPreferenceKey: PreferenceKey {
  public static var defaultValue: CGFloat = 0
  public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = max(value, nextValue())
	}
}



public struct EqualWidthModifier: ViewModifier {
	@Binding public  var width: CGFloat?
	
  public func body (content: Content) -> some View {
		content
			.frame(width: width)
			.background(
				GeometryReader { g in
					Color.clear
						.preference(key: EqualWidthPreferenceKey.self, value: g.size.width)
				}
			)
			.onPreferenceChange(EqualWidthPreferenceKey.self) { (value) in
				self.width = value
			}
	}
}

public extension View {
	func equalWidth (_ width: Binding<CGFloat?>) -> some View {
		modifier(EqualWidthModifier(width: width))
	}
}
