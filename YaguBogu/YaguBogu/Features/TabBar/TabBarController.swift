import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var scheduleCoordinator: ScheduleCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        tabBar.tintColor = .primary
        tabBar.unselectedItemTintColor = .gray03

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        // 구분선 제거
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        // 선택됨
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        ]

        // 비선택일때
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 13)!
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let nav = viewController as? UINavigationController else { return }
        
        if nav == scheduleCoordinator?.navigationController {
            scheduleCoordinator?.goToToday()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

