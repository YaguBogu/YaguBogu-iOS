import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CoreData

enum DetailMatchResult: String {
    case win = "TypeWinLarge"
    case lose = "TypeLoseLarge"
    case draw = "TypeDrawLarge"
    
    var koreanTitle: String{
        switch self{
        case .win:
            return "승리"
        case .lose:
            return "패배"
        case .draw:
            return "무승부"
        }
    }
    
    init<T: Comparable>(home: T, away: T) {
        if home > away {
            self = .win
        } else if home < away {
            self = .lose
        } else {
            self = .draw
        }
    }
}

final class DetailRecordModalView: BaseViewController {
    private let viewModel: DetailRecordViewModel
    
    private let scrollView = UIScrollView()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private var photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let contentContainerView = UIView()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleVStack, UIView(), resultVStack])
        stackView.axis = .horizontal
        stackView.alignment = .top
        return stackView
    }()
    
    private lazy var titleVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, gameDate])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var resultVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [gameResult, gameResultLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 22)
        label.textColor = .black
        return label
    }()
    
    private var gameDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.textColor = .gray07
        return label
    }()
    
    private var gameResult: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private var gameResultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12)
        label.textColor = .gray07
        return label
    }()
    
    private lazy var matchInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [teamInfoStackView, stadiumInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var teamInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [baseballImage, matchTeamlabel])
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private lazy var stadiumInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stadiumImage, stadiumNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 14
        return stackView
    }()
    
    private let baseballImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "baseball"))
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private var matchTeamlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .gray07
        return label
    }()
    
    private let stadiumImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "stadium"))
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private var stadiumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = .gray07
        return label
    }()
    
    private let topDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    private let bottomDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    private lazy var contentBodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentTitleLabel, contentLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: DetailRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
        setupData(with: viewModel.data)
    }
    
    override func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        mainStackView.addArrangedSubview(contentContainerView)
        
        contentContainerView.addSubview(contentStackView)
        
        [topDivider,headerStackView,matchInfoStackView,bottomDivider,contentBodyStackView].forEach{
            contentStackView.addArrangedSubview($0)
        }
        
        [photoImage,mainStackView].forEach{
            scrollView.addSubview($0)
        }
        
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoImage.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide).inset(42)
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(16)
            make.height.equalTo(photoImage.snp.width).multipliedBy(1.0)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(photoImage.snp.bottom)
            make.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
        
        baseballImage.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }
        stadiumImage.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }
        
        bottomDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        topDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
    
    private func setupData(with data: RecordData) {
        photoImage.backgroundColor = .lightGray
        titleLabel.text = viewModel.title
        gameDate.text = viewModel.gameDate
        matchTeamlabel.text = viewModel.matchTeamText
        stadiumNameLabel.text = viewModel.stadiumName
        contentLabel.text = viewModel.contentText
        
        gameResult.image = UIImage(named: viewModel.matchResult.rawValue)
        gameResultLabel.text = viewModel.matchResult.koreanTitle
        
        contentTitleLabel.text = "내용"
        
        contentTitleLabel.text = "내용"
        
        let contentLabelText = data.contentText
        contentLabel.text = contentLabelText
        contentLabel.setSpacingInPixels(text: contentLabelText, spacingInPx: 21)
    }
}
