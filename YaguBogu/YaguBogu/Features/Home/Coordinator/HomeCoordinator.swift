import UIKit

final class HomeCoordinator: BaseCoordinator {

    private let team: TeamInfo

    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }

    override func start() {
        let viewModel = HomeViewModel(team: team)
        let viewController = HomeViewController(viewModel: viewModel)

        navigationController.setViewControllers([viewController], animated: false)
    }
}
