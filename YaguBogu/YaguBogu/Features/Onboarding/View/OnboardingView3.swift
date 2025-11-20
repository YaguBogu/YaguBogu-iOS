import SwiftUI

struct OnboardingView3: View {
    
    var body: some View {
        VStack {
            HStack {
                    Text("경기일정\n한눈에 모아봤어요.")
                        .font(.system(size: 28, weight: .semibold))
                
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
    }
}
