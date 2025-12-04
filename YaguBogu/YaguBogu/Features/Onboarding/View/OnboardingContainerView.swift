import SwiftUI

struct OnboardingContainerView: View {
    let baseWidth: CGFloat = 402
    
    @StateObject var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                let w = geo.size.width
                
                // 배경
                Color(UIColor.bg)
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
                            .frame(height: (119 / baseWidth) * w)
                    }
                }
                .ignoresSafeArea(.container, edges: .bottom)
                
                // 하단 버튼
                if viewModel.currentPage < viewModel.totalPages {
                    OnboardingBottomView(
                        w: w,
                        currentPage: viewModel.currentPage,
                        totalPages: viewModel.totalPages,
                        nextAction: {
                            viewModel.nextButtonTapped()
                        }
                    )
                    .padding(.bottom, (16 / baseWidth) * w)
                }
            }
        }
    }
}
