import UIKit
import RxRelay
import RxSwift

final class CustomTabBarController: UIViewController {


    let homeTabReselected = PublishRelay<Void>()

    private let containerView = UIView()
    private let tabBarView = CustomTabBarView()
    private let tabBarContainerView = UIView()


    private var viewControllers: [UIViewController] = []
    private(set) var selectedIndex: Int = 0


    weak var scheduleCoordinator: ScheduleCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        bindTabBar()
    }

    func setViewControllers(_ vcs: [UIViewController]) {
        self.viewControllers = vcs
        tabBarView.configure(
            items: vcs.map { vc in
                let item = vc.tabBarItem
                return CustomTabBarItem(
                    title: item?.title ?? "",
                    defaultImage: item?.image,
                    selectedImage: item?.selectedImage
                )
            }
        )

        // 기본 탭 0 표시
        select(index: 0, isUserTap: false)
    }

    private func setupUI() {
        view.backgroundColor = .white
        tabBarContainerView.backgroundColor = .clear

        view.addSubview(containerView)
        view.addSubview(tabBarContainerView)

        tabBarContainerView.addSubview(tabBarView)
    }


    private func setupLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tabBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tabBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarContainerView.heightAnchor.constraint(equalToConstant: 98),

            tabBarView.topAnchor.constraint(equalTo: tabBarContainerView.topAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: tabBarContainerView.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: tabBarContainerView.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: tabBarContainerView.bottomAnchor)
        ])
    }


    private func bindTabBar() {
        tabBarView.onSelectIndex = { [weak self] tappedIndex in
            guard let self = self else { return }

            // 재탭 처리 (홈 탭)
            if tappedIndex == self.selectedIndex, tappedIndex == 0 {
                self.homeTabReselected.accept(())
                return
            }

            self.select(index: tappedIndex, isUserTap: true)
        }
    }

    private func select(index: Int, isUserTap: Bool) {
        guard index >= 0, index < viewControllers.count else { return }

        // 기존 차일드 제거
        if children.count > 0 {
            let currentVC = children[0]
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }

        // 새 차일드 붙이기
        let vc = viewControllers[index]
        addChild(vc)
        containerView.addSubview(vc.view)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vc.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            vc.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            vc.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            vc.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        // 인디케이터 영역
        vc.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 98, right: 0)

        vc.didMove(toParent: self)

        // UI 업데이트
        selectedIndex = index
        tabBarView.setSelected(index: index)


        if isUserTap,
           let nav = vc as? UINavigationController,
           nav == scheduleCoordinator?.navigationController {
            scheduleCoordinator?.goToToday()
        }
    }
}
