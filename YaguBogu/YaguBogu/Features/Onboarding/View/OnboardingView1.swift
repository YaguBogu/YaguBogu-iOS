import SwiftUI

struct OnboardingView1: View {
    
    let baseWidth: CGFloat = 402
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            
            VStack {
                Image("Onboarding1")
                    .resizable()
                    .frame(width: (200 / baseWidth) * w)
                    .frame(height: (200 / baseWidth) * w)
                    .padding(.bottom, (32 / baseWidth) * w)
                
                Text("야구장 날씨가 궁금하시죠?")
                    .font(.sdGothic(.title1, weight: .semibold))
                    .foregroundColor(Color(UIColor.appBlack))
                    .padding((10 / baseWidth) * w)
                
                Text("좋아하는 구단을 선택하고,")
                    .font(.sdGothic(.callout, weight: .medium))
                    .foregroundColor(Color(UIColor.gray05))
                
                Text("구장별 날씨를 한눈에 확인하세요.")
                    .font(.sdGothic(.callout, weight: .medium))
                    .foregroundColor(Color(UIColor.gray05))
            }
            .frame(width: w)
            .padding(.top, (165 / baseWidth) * w)
        }
    }
}
