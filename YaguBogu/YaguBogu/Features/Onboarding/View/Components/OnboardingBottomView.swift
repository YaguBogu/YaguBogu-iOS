import SwiftUI

struct OnboardingBottomView: View {
    let currentPage: Int
    let totalPages: Int
    
    var nextAction: () -> Void
    
    var body: some View {
        VStack {
            PageControlsView(currentPage: currentPage, totalPages: totalPages)
                .padding(.bottom, 30)
            
            NextButtonView(action: nextAction)
        }
    }
}
