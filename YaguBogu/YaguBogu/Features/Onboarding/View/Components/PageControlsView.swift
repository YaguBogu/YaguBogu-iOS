import SwiftUI

struct PageControlsView: View {
    let w: CGFloat
    let currentPage: Int
    let totalPages: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
            Capsule()
                    .fill(index == currentPage ? Color(UIColor.primary) : Color(UIColor.gray03))
                    .frame(width: index == currentPage ? 32 : 8,
                           height: (8 / 402) * w)
                    .cornerRadius(4)
            }
        }
    }
    
}
