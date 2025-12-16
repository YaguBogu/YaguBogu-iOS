import SwiftUI

struct OnboardingView3: View {
    
    let baseWidth: CGFloat = 402
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            
            VStack {
                HStack {
                    Text("경기 일정\n한눈에 모아봤어요.")
                        .font(.sdGothic(.title1, weight: .semibold))
                        .foregroundColor(Color(UIColor.appBlack))
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(
                            width: max((209 / baseWidth) * w, 230)
                        )
                    
                    Image("Onboarding3")
                        .resizable()
                        .frame(width: (117 / baseWidth) * w)
                        .frame(height: (115 / baseWidth) * w)
                }
                .frame(width: (332 / baseWidth) * w)
                .padding(.bottom, (24 / baseWidth) * w)
                
                Image("Onboarding3_1")
                    .resizable()
                    .frame(width: (295 / baseWidth) * w)
                    .frame(height: (302 / baseWidth) * w)
                    .cornerRadius(12)
            }
            .frame(width: w)
            .padding(.top, (80 / baseWidth) * w)
        }
    }
}
