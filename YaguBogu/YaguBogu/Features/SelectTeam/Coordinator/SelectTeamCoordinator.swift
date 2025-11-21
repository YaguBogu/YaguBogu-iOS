import UIKit
import RxSwift
import RxCocoa

final class SelectTeamCoordinator: BaseCoordinator {
    
    let didFinishSelect = PublishRelay<TeamInfo>()
    
    private let disposeBag = DisposeBag()

    override init(navigationController: UINavigationController) {
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewModel = TeamViewModel()
        let viewController = TeamViewController(viewModel: viewModel)

        viewModel.showAlert
            .subscribe(onNext: { [weak self] selectedTeam in
                self?.showConfirmationAlert(for: selectedTeam)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func showConfirmationAlert(for team: TeamInfo) {
        let alertCoordinator = CustomAlertCoordinator(
            navigationController: self.navigationController,
            title: "선택한 구단으로 시작할까요?",
            message: "선택 이후에는 변경할 수 없어요!"
        )
        
        self.addChild(alertCoordinator)
        
        alertCoordinator.start { [weak self] action in
            guard let self = self else { return }
            
            self.removeChild(alertCoordinator)
            
            if action == .confirm {
                self.didFinishSelect.accept(team)
            }
        }
    }
}
