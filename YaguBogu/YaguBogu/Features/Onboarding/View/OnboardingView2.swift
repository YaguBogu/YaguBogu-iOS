import SwiftUI

struct OnboardingView2: View {
    
    var body: some View {
        VStack{
            Text("직관 순간을 기록해보세요!")
                .font(.custom("AppleSDGothicNeo-SemiBold", size: 28))
                .padding(10)
            Text("사진과 텍스트로 편하게 기록하고,")
                .font(.custom("AppleSDGothicNeo-Medium", size: 16))
                .foregroundColor(Color(red: 143/255, green: 143/255, blue: 143/255))
            
            Text("기록들을 모아서 확인할 수 있어요.")
                .font(.custom("AppleSDGothicNeo-Medium", size: 16))
                .foregroundColor(Color(red: 143/255, green: 143/255, blue: 143/255))
                .padding(.bottom, 32)
            
            Image("Onboarding2")
                .resizable()
                .frame(width: 200, height: 200)
        }
        .padding(.top, 165)
    }
}
