import UIKit

class BaseCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [BaseCoordinator] = []
    let titleTextFont = [ NSAttributedString.Key.foregroundColor: UIColor.appBlack, NSAttributedString.Key.font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17) ]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    

    func start() {
        navigationController.navigationBar.titleTextAttributes = titleTextFont as [NSAttributedString.Key : Any]
    }
    
    
    func addChild(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    
    func removeChild(_ coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

