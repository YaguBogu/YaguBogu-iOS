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

        viewModel.navigateToDetail
            .subscribe(onNext: { [weak self] selectedTeam in
                self?.didFinishSelect.accept(selectedTeam)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([viewController], animated: true)
    }
}
