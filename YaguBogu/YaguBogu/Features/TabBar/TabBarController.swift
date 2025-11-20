import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = .white
        tabBar.tintColor = .primary
        tabBar.unselectedItemTintColor = .gray03
    }
}

