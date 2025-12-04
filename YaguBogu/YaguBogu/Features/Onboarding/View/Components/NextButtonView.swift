import SwiftUI

struct NextButtonView: View {
    let w: CGFloat
    let buttonColor = Color(red: 255/255, green: 114/255, blue: 116/255)
    var action: () -> Void
    
    var body: some View {
            Button(action: {
                self.action()
            }) {
                Text("다음")
                    .font(.custom("AppleSDGothicNeo-SemiBold", size: 16))
                    .foregroundColor(Color(UIColor.appWhite))
                    .frame(width: (343 / 402) * w, height: (57 / 402) * w)
            }
        .background(buttonColor)
        .cornerRadius(12)
    }
}
