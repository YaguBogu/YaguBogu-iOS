import SwiftUI

struct OnboardingView2: View {
    
    let baseWidth: CGFloat = 402
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            VStack{
                Text("직관 순간을 기록해보세요!")
                    .font(.sdGothic(.title1, weight: .semibold))
                    .foregroundColor(Color(UIColor.appBlack))

                    .padding((10 / baseWidth) * w)
                
                Text("사진과 텍스트로 편하게 기록하고,")
                    .font(.sdGothic(.callout, weight: .medium))
                    .foregroundColor(Color(UIColor.gray05))

                Text("기록들을 모아서 확인할 수 있어요.")
                    .font(.sdGothic(.callout, weight: .medium))
                    .foregroundColor(Color(UIColor.gray05))
                    .padding(.bottom, (32 / baseWidth) * w)
                
                Image("Onboarding2")
                    .resizable()
                    .frame(width: (200 / baseWidth) * w)
                    .frame(height: (200 / baseWidth) * w)
            }
            .frame(width: w)
            .padding(.top, (165 / baseWidth) * w)
        }
    }
}
