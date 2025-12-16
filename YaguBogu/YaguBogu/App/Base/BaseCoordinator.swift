import UIKit

class BaseCoordinator {
    var navigationController: UINavigationController
    var childCoordinators: [BaseCoordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    

    func start() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .bg
        appearance.shadowColor = .clear
        
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.appBlack,
            .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
        ]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
    }
    
    
    func addChild(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    
    func removeChild(_ coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

