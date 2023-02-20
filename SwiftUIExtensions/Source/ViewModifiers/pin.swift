import SwiftUI

struct PinnedViewModifier<V: View>: ViewModifier {
  @State private var paddingSize: Double = 0

  let edge: Edge
  let view: V

  var paddingEdge: Edge.Set {
    switch edge {
    case .leading: return .leading
    case .top: return .top
    case .trailing: return .trailing
    case .bottom: return .bottom
    }
  }

  var alignment: Alignment {
    switch edge {
    case .top: return .top
    case .leading: return .leading
    case .bottom: return .bottom
    case .trailing: return .trailing
    }
  }

  var paddingSizeDimension: KeyPath<CGSize, CGFloat> {
    switch edge {
    case .top, .bottom: return \.height
    case .leading, .trailing: return \.width
    }
  }

  init (edge: Edge, view: () -> V) {
    self.edge = edge
    self.view = view()
  }

  func body(content: Content) -> some View {
    ZStack(alignment: alignment) {
      content
        .padding(paddingEdge, paddingSize)

      view
        .background {
          GeometryReader { g in
            Color.clear.onAppear { paddingSize = g.size[keyPath: paddingSizeDimension] }
          }
        }
    }
  }
}

extension View {
  func pin (to edge: Edge, _ view: () -> some View) -> some View {
    modifier(PinnedViewModifier(edge: edge, view: view))
  }
}

struct MyPreview_Previews: PreviewProvider {
  static var previews: some View {
    TabView {
      List(0..<20) { item in
        Text("\(item)")
      }
      .pin(to: .bottom) {
        Text("Some content")
          .frame(maxWidth: .infinity)
          .padding()
          .background(Color.red)
      }
    }
  }
}
