import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()

    override func start() {
        showSplash()
    }

    private func showSplash() {

        let vm = SplashViewModel()
        let vc = SplashViewController(viewModel: vm)

        // '스플래시 끝남' 이벤트 구독
        vm.finishTrigger
            .subscribe(onNext: { [weak self] in
                print("스플래시가 끝남")
                // 다음 동작은 이후 브랜치에서 추가
                
                if let savedTeam = TeamDataUserDefaults.shared.getSelectedTeam(){
                    self?.showHome(with: savedTeam)
                } else {
                    self?.showSelectTeam()
                }
            })
            .disposed(by: disposeBag)

        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showSelectTeam() {
        let teamCoordinator = SelectTeamCoordinator(navigationController: navigationController)
        
        teamCoordinator.didFinishSelect
            .subscribe(onNext: {[weak self] selectTeam in
                print(selectTeam)
                
                TeamDataUserDefaults.shared.saveSelectedTeam(selectTeam)
                
                self?.removeChild(teamCoordinator)
                self?.showHome(with: selectTeam)
            })
            .disposed(by: disposeBag)
        
        addChild(teamCoordinator)
        teamCoordinator.start()
    }
    
    
    private func showHome(with team: TeamInfo){
        let homeVM = HomeViewModel(team: team)
        let homeVC = HomeViewController(viewModel: homeVM)
        
        
        navigationController.setViewControllers([homeVC], animated: true)
    }
}

