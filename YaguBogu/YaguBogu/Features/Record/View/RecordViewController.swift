import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RecordViewController: BaseViewController {

    private let viewModel: RecordViewModel

    init(viewModel: RecordViewModel) {
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

