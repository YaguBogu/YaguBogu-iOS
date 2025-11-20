import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentPage = 0
    @Published var totalPages = 3
    
    var onFlowCompleted: (() -> Void)?
    
    // 버튼 탭 시 호출될 로직
    func nextButtonTapped() {
        withAnimation(.easeInOut) {
            if self.currentPage < self.totalPages {
                self.currentPage += 1
            }
        }
        
        if self.currentPage == self.totalPages {
            self.onFlowCompleted?()
        }
    }
}
