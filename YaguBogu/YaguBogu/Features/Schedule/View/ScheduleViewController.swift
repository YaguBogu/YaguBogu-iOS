import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ScheduleViewController: BaseViewController {

    private let viewModel: ScheduleViewModel

    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


