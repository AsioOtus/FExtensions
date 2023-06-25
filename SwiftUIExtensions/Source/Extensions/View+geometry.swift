import SwiftUI

public extension View {
  func geometry(
    handler: @escaping (GeometryProxy) -> Void
  ) -> some View {
    background(
      GeometryReader { g in
        Color.clear
          .perform {
            handler(g)
          }
      }
    )
  }

  func geometry(
    value: Binding<GeometryProxy>
  ) -> some View {
    background(
      GeometryReader { g in
        Color.clear
          .perform {
            value.wrappedValue = g
          }
      }
    )
  }
}
