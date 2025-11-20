import SwiftUI
import UIKit

final class OnboardingCoordinator: BaseCoordinator {
    
    var didFinish: (() -> Void)?
    
    override func start() {
        let viewModel = OnboardingViewModel()
        let view = OnboardingContainerView(viewModel: viewModel)
        
        viewModel.onFlowCompleted = { [weak self] in
            self?.didFinish?()
        }
        
        let hostingVC = UIHostingController(rootView: view)
        
        navigationController.setViewControllers([hostingVC], animated: true)
    }
}
