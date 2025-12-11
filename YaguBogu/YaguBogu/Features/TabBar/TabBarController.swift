import UIKit
import RxRelay
import RxSwift

final class TabBarController: UITabBarController {
    
    let homeTabReselected = PublishRelay<Void>()
    private var previousIndex = 0
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

        // 선택 상태
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                ?? UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.primary
        ]

        // 비선택 상태
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
                ?? UIFont.systemFont(ofSize: 14, weight: .medium),
            .foregroundColor: UIColor.gray03
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {

        let current = tabBarController.selectedIndex

        if current == 0, previousIndex == 0 {
            homeTabReselected.accept(()) // 재탭 이벤트 발생하게하기
        }

        previousIndex = current
        
        guard let nav = viewController as? UINavigationController else { return }
        
        if nav == scheduleCoordinator?.navigationController {
            scheduleCoordinator?.goToToday()
        }
    }
}
