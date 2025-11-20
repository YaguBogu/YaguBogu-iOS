import UIKit

final class ScheduleCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = ScheduleViewModel()
        let viewController = ScheduleViewController(viewModel: viewModel)

        navigationController.setViewControllers([viewController], animated: false)
    }
}

