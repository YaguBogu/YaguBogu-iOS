import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    let viewModel: SplashViewModel

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 애니메이션이 끝나면
        viewModel.splashDidFinish()
    }
}

