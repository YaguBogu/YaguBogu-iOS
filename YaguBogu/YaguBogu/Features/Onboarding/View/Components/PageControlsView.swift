import SwiftUI

struct PageControlsView: View {
    
    let currentPage: Int
    let totalPages: Int
    
    let activeColor = Color(red: 255/255, green: 114/255, blue: 116/255)
    let inactiveColor = Color(red: 194/255, green: 194/255, blue: 194/255)
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalPages, id: \.self) { index in
            Capsule()
                    .fill(index == currentPage ? activeColor : inactiveColor)
                    .frame(width: index == currentPage ? 32 : 8,
                           height: 8)
                    .cornerRadius(4)
            }
        }
    }
    
}
