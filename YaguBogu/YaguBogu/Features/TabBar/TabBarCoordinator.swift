import UIKit

final class TabBarCoordinator: BaseCoordinator {

    private let team: TeamInfo

    init(navigationController: UINavigationController, team: TeamInfo) {
        self.team = team
        super.init(navigationController: navigationController)
    }

    override func start() {
        let tabBarController = TabBarController()

        // 홈 탭
        let homeVM = HomeViewModel(team: team)
        let homeVC = HomeViewController(viewModel: homeVM)
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)

        // 경기일정 탭
        let scheduleVC = ScheduleViewController()
        let scheduleNav = UINavigationController(rootViewController: scheduleVC)
        scheduleNav.tabBarItem = UITabBarItem(title: "경기 일정", image: UIImage(systemName: "calendar"), tag: 1)

        // 직관기록 탭
        let recordVC = RecordViewController()
        let recordNav = UINavigationController(rootViewController: recordVC)
        recordNav.tabBarItem = UITabBarItem(title: "직관 기록", image: UIImage(systemName: "list.bullet.rectangle"), tag: 2)

        tabBarController.viewControllers = [homeNav, scheduleNav, recordNav]

        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    



}

