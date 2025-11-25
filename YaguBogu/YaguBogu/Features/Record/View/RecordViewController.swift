import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class RecordViewController: BaseViewController {
    
    private let viewModel: RecordViewModel
    private let notingView = NothingRecordView()
    
    private let floatingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "floatingbutton"), for: .normal)
        button.layer.shadowColor = UIColor.appBlack.cgColor
        button.layer.shadowOpacity = 0.16
        button.layer.shadowRadius = 16
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        return button
    }()
    
    init(viewModel: RecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadMergeData()
        
    }
    
    override func configureUI() {
        super.configureUI()
        [notingView,floatingButton].forEach{
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        notingView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints{ make in
            make.trailing.equalToSuperview().offset(-26)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-26)
        }
    }
}
