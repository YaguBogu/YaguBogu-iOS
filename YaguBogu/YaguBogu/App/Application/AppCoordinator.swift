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
                
                if let savedTeam = TeamDataUserDefaults.shared.getSelectedTeam(){
                    self?.showTabBar(with: savedTeam)
                } else {
                    self?.showOnboarding { [weak self] in
                        self?.showSelectTeam()
                    }
                }
            })
            .disposed(by: disposeBag)

        navigationController.setViewControllers([vc], animated: false)
    }
    
    private func showOnboarding(completion: @escaping () -> Void) {
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        
        onboardingCoordinator.didFinish = { [ weak self, weak onboardingCoordinator] in
            guard let self = self, let onboardingCoordinator = onboardingCoordinator else { return }
            
            self.removeChild(onboardingCoordinator)
            
            completion()
        }
        addChild(onboardingCoordinator)
        onboardingCoordinator.start()
    }
    
    private func showSelectTeam() {
        let teamCoordinator = SelectTeamCoordinator(navigationController: navigationController)
        
        teamCoordinator.didFinishSelect
            .subscribe(onNext: {[weak self] selectTeam in
                print(selectTeam)
                
                TeamDataUserDefaults.shared.saveSelectedTeam(selectTeam)
                
                self?.removeChild(teamCoordinator)
                self?.showTabBar(with: selectTeam)
            })
            .disposed(by: disposeBag)
        
        addChild(teamCoordinator)
        teamCoordinator.start()
    }
    
    
    private func showTabBar(with team: TeamInfo) {
        let tabBarCoordinator = TabBarCoordinator(
            navigationController: navigationController,
            team: team
        )

        addChild(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}

