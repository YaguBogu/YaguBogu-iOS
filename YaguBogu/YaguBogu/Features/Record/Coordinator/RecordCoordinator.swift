import UIKit


final class RecordCoordinator: BaseCoordinator {
    
    private let team: TeamInfo
    
    init(navigationController:UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        let viewModel = RecordViewModel(team: team)
        let viewController = RecordViewController(viewModel: viewModel)
        
        navigationController.setViewControllers([viewController], animated: false)
    }
}

