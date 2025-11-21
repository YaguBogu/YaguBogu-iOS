import SwiftUI

struct OnboardingView3: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("경기 일정\n한눈에 모아봤어요.")
                    .font(.custom("AppleSDGothicNeo-SemiBold", size: 28))
                    .frame(width: 209)
                
                Image("Onboarding3")
                    .resizable()
                    .frame(width: 117, height: 115)
            }
            .frame(width: 332)
            .padding(.bottom, 24)
            
            Image("Onboarding3_1")
                .resizable()
                .frame(width: 295, height: 304)
                .cornerRadius(12)
        }
        .padding(.top, 80)
    }
}
