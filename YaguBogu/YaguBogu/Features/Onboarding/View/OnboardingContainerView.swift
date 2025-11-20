import SwiftUI

struct OnboardingContainerView: View {
    @StateObject var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // 배경
            Color(red: 248/255, green: 248/255, blue: 250/255)
                .ignoresSafeArea()
            
            // 페이지 콘텐츠
            ScrollView {
                VStack {
                    switch viewModel.currentPage {
                    case 0: OnboardingView1()
                    case 1: OnboardingView2()
                    case 2: OnboardingView3()
                    default: EmptyView()
                    }
                    Spacer()
                        .frame(height: 119)
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            
            // 하단 버튼
            if viewModel.currentPage < viewModel.totalPages {
                OnboardingBottomView(
                    currentPage: viewModel.currentPage,
                    totalPages: viewModel.totalPages,
                    nextAction: {
                        viewModel.nextButtonTapped()
                    }
                )
                .padding(.bottom, 16)
            }
        }
    }
}
