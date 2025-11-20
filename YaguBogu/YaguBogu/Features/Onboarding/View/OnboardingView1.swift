import SwiftUI

struct OnboardingView1: View {
    
    var body: some View {
        VStack{
            Spacer()
            
            Image("Onboarding1")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom, 32)
            
            Text("야구장 날씨가 궁금하시죠?")
                .font(.system(size: 28, weight: .semibold))
                .padding(10)
            
            Text("좋아하는 구단을 선택하고,")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 143/255, green: 143/255, blue: 143/255))
            
            Text("구장별 날씨를 한눈에 확인하세요.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color(red: 143/255, green: 143/255, blue: 143/255))
        }
        .padding(.top, 165)
    }
}
