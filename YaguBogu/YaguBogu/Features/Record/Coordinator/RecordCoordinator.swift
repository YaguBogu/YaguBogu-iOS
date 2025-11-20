import UIKit

final class RecordCoordinator: BaseCoordinator {

    override func start() {
        let viewModel = RecordViewModel()
        let viewController = RecordViewController(viewModel: viewModel)

        navigationController.setViewControllers([viewController], animated: false)
    }
}

