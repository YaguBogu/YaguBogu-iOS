import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

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


