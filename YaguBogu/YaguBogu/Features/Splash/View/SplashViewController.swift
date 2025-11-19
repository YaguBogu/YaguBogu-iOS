import UIKit
import SnapKit

final class SplashViewController: BaseViewController {

    // 뷰모델
    private let viewModel: SplashViewModel

    // 컬러
    private let backgroundColor = UIColor(
        red: 248/255.0,
        green: 248/255.0,
        blue: 250/255.0,
        alpha: 1.0
    )

    private let primaryPink = UIColor(
        red: 244/255.0,
        green: 144/255.0,
        blue: 146/255.0,
        alpha: 1.0
    )

    // UI

    private let logoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "splashLogo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 25
        paragraph.maximumLineHeight = 25
        paragraph.alignment = .center

        let attributed = NSAttributedString(
            string: "즐거운 야구 생활, 야구보구",
            attributes: [
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 20)!,
                .foregroundColor: primaryPink,
                .paragraphStyle: paragraph
            ]
        )

        label.attributedText = attributed
        label.textAlignment = .center
        return label
    }()

    // Init

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.viewModel.splashDidFinish()
        }
    }

    // BaseViewController 오버라이드

    override func configureUI() {
        view.backgroundColor = backgroundColor

        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
    }

    override func setupConstraints() {

        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.height.equalTo(100)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(211)
            $0.height.equalTo(25)
        }
    }
}

