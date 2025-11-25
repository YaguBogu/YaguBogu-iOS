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
        let vm = HomeViewModel(team: team)
        self.homeViewModel = vm

        let vc = HomeViewController(viewModel: vm)
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func showStadiumSelect() {
        let vc = StadiumSelectViewController()

        vc.selectedStadium
            .subscribe(onNext: { [weak self] stadiumInfo in
                self?.homeViewModel?.updateSelectedStadium(stadiumInfo)
            })
            .disposed(by: disposeBag)

        // 모달 시트 크기 (375 x 374)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return 374
                }
            ]
            sheet.prefersGrabberVisible = true     // 핸들바
            sheet.preferredCornerRadius = 38
        }

        vc.modalPresentationStyle = .pageSheet
        navigationController.present(vc, animated: true)
    }



}

