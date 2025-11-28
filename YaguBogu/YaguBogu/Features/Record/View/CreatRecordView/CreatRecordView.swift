
import UIKit
import SnapKit

class CreateRecordView: BaseViewController {
    
    private var viewModel: CreateViewModel
    
    init(viewModel: CreateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "직관 기록 작성"
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cross"), for: .normal)
        return button
    }()
    
    private let scrollView = UIScrollView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let selectGameView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let selectTextLabel: UILabel = {
        let label = UILabel()
        label.text = "경기 선택"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let selectText: UILabel = {
        let label = UILabel()
        label.text = "선택"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .gray04
        return label
    }()
    
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "right")
        return image
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        let font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
        textField.attributedPlaceholder = NSAttributedString(
            string: "제목을 입력해 주세요.",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.gray04,
                NSAttributedString.Key.font : font
            ]
        )
        textField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        textField.addLeftPadding(width: 16)
        
        textField.textColor = .appBlack
        return textField
    }()
    
    private lazy var contentPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "글을 작성해 주세요."
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .gray04
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 8
        textView.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        textView.textColor = .appBlack
        textView.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        return textView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 8
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let photoTitle: UILabel = {
        let label = UILabel()
        label.text = "사진 추가"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .appBlack
        return label
    }()
    
    private let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray01
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let photoDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    private let photoPlaceholderIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photoPlus")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let photoPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 불러오기"
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        label.textColor = .gray04
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    let photoPlaceHolderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor.appBlack.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: -4)
        view.layer.shadowRadius = 8
        view.layer.masksToBounds = false
        return view
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        button.setTitle("게시", for: .normal)
        button.titleLabel?.textColor = .appWhite
        button.backgroundColor = .primary
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    override func configureUI() {
        super.configureUI()
        
        [headerView,scrollView,bottomView].forEach{
            view.addSubview($0)
        }
        
        [cancelButton, titleLabel].forEach{
            headerView.addSubview($0)
        }
        
        [confirmButton].forEach{
            bottomView.addSubview($0)
        }
        
        scrollView.addSubview(contentStackView)
        
        [selectGameView,
         titleTextField,
         contentTextView,
         photoImageView].forEach{
            contentStackView.addArrangedSubview($0)
        }
        
        [selectTextLabel, selectText, arrowImage].forEach {
            selectGameView.addSubview($0)
        }
        
        contentTextView.addSubview(contentPlaceholderLabel)
        
        [photoTitle, photoImage,photoPlaceHolderStackView,photoDeleteButton].forEach{
            photoImageView.addSubview($0)
        }
        
        [photoPlaceholderIcon, photoPlaceholderLabel].forEach {
            photoPlaceHolderStackView.addArrangedSubview($0)
        }
        
    }
    override func setupConstraints() {
        super.setupConstraints()
        
        headerView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        cancelButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().inset(26)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(bottomView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(57)
        }
        
        scrollView.snp.makeConstraints{ make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        contentStackView.snp.makeConstraints{ make in
            make.edges.equalTo(scrollView.contentLayoutGuide).inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
            make.width.equalTo(scrollView.frameLayoutGuide).offset(-40)
        }
        
        selectGameView.snp.makeConstraints{ make in
            make.height.equalTo(46)
        }
        
        selectTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        selectText.snp.makeConstraints { make in
            make.trailing.equalTo(arrowImage.snp.leading).offset(-6)
            make.centerY.equalToSuperview()
        }
        
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        contentPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(16)
        }
        
        photoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(16)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(photoTitle.snp.bottom).offset(8)
            make.trailing.leading.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(14)
            make.height.equalTo(photoImage.snp.width)
        }
        
        photoPlaceHolderStackView.snp.makeConstraints { make in
            make.center.equalTo(photoImage)
            make.height.equalTo(56)
            make.width.equalTo(77)
        }
        
        photoDeleteButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    private func bind(){
        cancelButton.rx.tap
            .bind(to: viewModel.cancelButtonTapped)
            .disposed(by: disposeBag)
    }
    
}

extension CreateRecordView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}

extension UITextField {
    func addLeftPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
