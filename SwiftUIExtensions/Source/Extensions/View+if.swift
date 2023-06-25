import SwiftUI

public extension View {
	@ViewBuilder
	func `if` <IfContent> (
		_ condition: Bool,
		ifTransform: (Self) -> IfContent
  ) -> some View where IfContent: View {
		if condition {
      ifTransform(self)
    } else {
      self
    }
	}

  @ViewBuilder
  func `if` <IfContent, ElseContent> (
    _ condition: Bool,
    ifTransform: (Self) -> IfContent,
    else elseTransform: (Self) -> ElseContent
  ) -> some View where IfContent: View, ElseContent: View {
    if condition {
      ifTransform(self)
    } else {
      elseTransform(self)
    }
  }
}
