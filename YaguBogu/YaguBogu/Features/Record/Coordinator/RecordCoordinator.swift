import UIKit


final class RecordCoordinator: BaseCoordinator {
    
    private let team: TeamInfo
    
    
    init(navigationController:UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        let viewModel = RecordViewModel(team: team)
        let viewController = RecordViewController(viewModel: viewModel)
        viewController.navigationItem.title = "나의 직관 기록"
        navigationController.setViewControllers([viewController], animated: false)
    }
}

