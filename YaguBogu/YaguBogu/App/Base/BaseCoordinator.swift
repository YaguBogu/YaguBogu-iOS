import UIKit

class BaseCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [BaseCoordinator] = []
    

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    

    func start() { }
    
    
    func addChild(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    
    func removeChild(_ coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

