import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class HomeCoordinator: BaseCoordinator {

    private let team: TeamInfo
    private var homeViewModel: HomeViewModel?
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }

    override func start() {
        navigationController.isNavigationBarHidden = true
        
        let viewModel = HomeViewModel(team: team)
        self.homeViewModel = viewModel

        let viewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showStadiumSelect() {
        let viewController = StadiumSelectViewController()
        
        guard let viewModel = homeViewModel else { return }

        // 구장 선택 스트림을 뷰모델 인풋에 바인딩함
        viewController.selectedStadium
            .bind(to: viewModel.stadiumSelected)
            .disposed(by: disposeBag)

        // 모달 시트 크기 (375 x 374)
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return 374
                }
            ]
            sheet.prefersGrabberVisible = true     // 핸들바
            sheet.preferredCornerRadius = 38
        }

        viewController.modalPresentationStyle = .pageSheet
        navigationController.present(viewController, animated: true)
    }
}

