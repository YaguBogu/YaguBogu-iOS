import UIKit

final class ScheduleCoordinator: BaseCoordinator {
    private let team: TeamInfo
    
    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        let viewModel = ScheduleViewModel(team: team)
        let viewController = ScheduleViewController(viewModel: viewModel)
        viewController.navigationItem.title = "전체 경기 일정"
        navigationController.setViewControllers([viewController], animated: false)
    }
}

