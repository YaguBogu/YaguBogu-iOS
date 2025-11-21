import SwiftUI

struct NextButtonView: View {
    let buttonColor = Color(red: 255/255, green: 114/255, blue: 116/255)
    
    var action: () -> Void
    
    var body: some View {
            Button(action: {
                self.action()
                print("버튼이 눌림")
            }) {
                Text("다음")
                    .font(.custom("AppleSDGothicNeo-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .frame(width: 343, height: 57)
            }
        .background(buttonColor)
        .cornerRadius(12)
    }
}
