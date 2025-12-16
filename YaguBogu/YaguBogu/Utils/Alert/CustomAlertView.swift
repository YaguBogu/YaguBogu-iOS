
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomAlertView:BaseViewController{
    private let viewModel: CustomAlertViewModel
    
    init(viewModel: CustomAlertViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    private var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "커스텀 알림 제목"
        label.font = .sdGothic(.alertTitle, weight: .bold)
        label.textColor = .appBlack
        label.textAlignment = .center
        
        return label
    }()
    
    private var messageLabel:UILabel = {
        let label = UILabel()
        label.text = "커스텀 메세지"
        label.font = .sdGothic(.alertMessage, weight: .medium)
        label.textColor = .appBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("커스텀 버튼", for: .normal)
        button.titleLabel?.font = .sdGothic(.alertButton, weight: .semibold)
        button.setTitleColor(.primary, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.primary.cgColor
        button.backgroundColor = .appWhite
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("커스텀 버튼", for: .normal)
        button.titleLabel?.font = .sdGothic(.alertButton, weight: .semibold)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.primary.cgColor
        button.backgroundColor = .primary
        button.layer.cornerRadius = 12
        return button
    }()
    
    private var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 24
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    private var textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    private var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        bind()
    }
    
    override func configureUI() {
        super.configureUI()
        mainStackView.layoutMargins = UIEdgeInsets(top: 24, left: 16, bottom: 16, right: 16)
        
        [backgroundView,alertView].forEach{
            view.addSubview($0)
        }
        
        [mainStackView].forEach{
            alertView.addSubview($0)
        }
        
        [titleLabel,messageLabel].forEach{
            textStackView.addArrangedSubview($0)
        }
        
        [cancelButton,confirmButton].forEach{
            buttonStackView.addArrangedSubview($0)
        }
        
        [textStackView,buttonStackView].forEach{
            mainStackView.addArrangedSubview($0)
        }
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
    }
    
    private func bind(){
        cancelButton.rx.tap
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .bind(to: viewModel.confirmButtonTapped)
            .disposed(by: disposeBag)
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setMessage(_ message: String) {
        self.messageLabel.text = message
    }
    
    func setCancelButtonText(_ cancelTitle: String) {
        self.cancelButton.setTitle(cancelTitle, for: .normal)
    }
    
    func setConfirmButtonText(_ confirmTitle: String) {
        self.confirmButton.setTitle(confirmTitle, for: .normal)
    }
    
    func hideCancelButton(){
        cancelButton.isHidden = true
        
        buttonStackView.removeArrangedSubview(cancelButton)
        
        cancelButton.removeFromSuperview()
    }
}
