import UIKit
import RxSwift

final class AppCoordinator: BaseCoordinator {

    private let disposeBag = DisposeBag()

    override func start() {
        showSplash()
    }

    private func showSplash() {

        let vm = SplashViewModel()
        let vc = SplashViewController(viewModel: vm)

        // '스플래시 끝남' 이벤트 구독
        vm.finishTrigger
            .subscribe(onNext: { [weak self] in
                print("스플래시가 끝남")
                // 다음 동작은 이후 브랜치에서 추가
            })
            .disposed(by: disposeBag)

        navigationController.setViewControllers([vc], animated: false)
    }
}

