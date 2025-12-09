import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()

    override func start() {
        versionCheck()
    }
    private func versionCheck(){
        AppVersion.latestVersion{[weak self] appStoreVersion in
            DispatchQueue.main.async{
                guard let self = self else {return}
                
                guard let appStoreVersion = appStoreVersion,
                      let currentVersion = AppVersion.appVersion,
                      AppVersion.isMinorVersionUpdated(currentVersion: currentVersion, appStoreVersion: appStoreVersion) else {
                    self.showSplash()
                    return
                }
                self.showUpdateAlert()
            }
        }
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
    
    private func showUpdateAlert(){
        let alertCoordinator = CustomAlertCoordinator(
            navigationController: self.navigationController,
            title: "업데이트 알림",
            message: "최신 버전이 출시되었습니다. 원활한 서비스 이용을 위해 업데이트를 진행해주세요.",
            cancelTitle: nil,
            confirmTitle: "업데이트"
        )
        
        addChild(alertCoordinator)
        alertCoordinator.start{[weak self] action in
            guard let self = self else { return }
            
            if action == .confirm{
                AppVersion.openAppStore()
            }
            
            self.removeChild(alertCoordinator)
        }
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

