import SwiftUI

struct OnboardingBottomView: View {
    let w: CGFloat
    let currentPage: Int
    let totalPages: Int
    var nextAction: () -> Void
    
    var body: some View {
        VStack {
            PageControlsView(
                w: w,
                currentPage: currentPage,
                totalPages: totalPages
            )
                .padding(.bottom, 30)
            
            NextButtonView(w: w, action: nextAction)
        }
    }
}
