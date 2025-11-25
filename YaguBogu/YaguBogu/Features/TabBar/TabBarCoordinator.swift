import UIKit

final class TabBarCoordinator: BaseCoordinator {

    private let team: TeamInfo

    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }

    override func start() {
        let tabBarController = TabBarController()

        // 홈
        let homeNav = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNav, team: team)
        addChild(homeCoordinator)
        homeCoordinator.start()
        homeNav.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(named: "tab_home_default"),
            selectedImage: UIImage(named: "tab_home_selected")
        )

        // 경기일정
        let scheduleNav = UINavigationController()
        let scheduleCoordinator = ScheduleCoordinator(navigationController: scheduleNav, team: team)
        addChild(scheduleCoordinator)
        scheduleCoordinator.start()
        scheduleNav.tabBarItem = UITabBarItem(
            title: "경기 일정",
            image: UIImage(named: "tab_schedule_default"),
            selectedImage: UIImage(named: "tab_schedule_selected")
        )

        // 직관기록
        let recordNav = UINavigationController()
        let recordCoordinator = RecordCoordinator(navigationController: recordNav)
        addChild(recordCoordinator)
        recordCoordinator.start()
        recordNav.tabBarItem = UITabBarItem(
            title: "직관 기록",
            image: UIImage(named: "tab_record_default"),
            selectedImage: UIImage(named: "tab_record_selected")
        )

        tabBarController.viewControllers = [homeNav, scheduleNav, recordNav]

        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

