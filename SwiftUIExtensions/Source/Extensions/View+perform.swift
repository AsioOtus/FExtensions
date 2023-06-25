import SwiftUI

public extension View {
  func perform(_ action: @escaping () -> Void) -> some View {
    RunLoop.main.perform {
      action()
    }
    return self
  }
}
