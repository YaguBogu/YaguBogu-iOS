import UIKit
import RxSwift
import RxGesture
import RxCocoa
import SnapKit

class HomeViewController: BaseViewController {
    
    weak var coordinator: HomeCoordinator?
    
    private let viewModel: HomeViewModel
    
    private let headerContainer = UIView()

    private let headerLogoImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "headerLogo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    

    private let stadiumTapArea = UIView()
    private let stadiumLabel = UILabel()
    private let downIcon = UIImageView(image: UIImage(named: "downIcon"))


    private let weatherContainer = UIView()
    private let tempLabel = UILabel()
    
    private let rightStack = UIStackView()
    private let rainLabel = UILabel()
    private let humidityLabel = UILabel()
    private let windLabel = UILabel()

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러메세지")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func configureUI() {
        super.configureUI()
        
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerLogoImageView)
        headerContainer.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        
        view.addSubview(stadiumTapArea)
        stadiumTapArea.addSubview(stadiumLabel)
        stadiumTapArea.addSubview(downIcon)
        stadiumTapArea.isUserInteractionEnabled = true
        

        stadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.alignment = .center

        

        view.addSubview(weatherContainer)
        weatherContainer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        
        weatherContainer.addSubview(tempLabel)
        
        rightStack.axis = .vertical
        rightStack.spacing = 6
        rightStack.alignment = .trailing
        rightStack.distribution = .equalSpacing
        
        rightStack.addArrangedSubview(rainLabel)
        rightStack.addArrangedSubview(humidityLabel)
        rightStack.addArrangedSubview(windLabel)
        
        weatherContainer.addSubview(rightStack)
    }

    override func setupConstraints() {
        super.setupConstraints()
        

        headerContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        headerLogoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(28)
        }
        

        stadiumTapArea.snp.makeConstraints { make in
            make.top.equalTo(headerContainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(42)
        }


        stadiumLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }


        downIcon.snp.makeConstraints { make in
            make.leading.equalTo(stadiumLabel.snp.trailing).offset(4)
            make.centerY.equalTo(stadiumLabel)
            make.width.height.equalTo(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16)
        }


        weatherContainer.snp.makeConstraints { make in
            make.top.equalTo(stadiumTapArea.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        
        tempLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(130) // 원래 114인데, 잘려서 늘림
            make.height.equalTo(80)
        }
        
        rightStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(76)
            make.height.equalTo(66)
        }
        
        [rainLabel, humidityLabel, windLabel].forEach { label in
            label.snp.makeConstraints { make in
                make.height.equalTo(18)
            }
        }
    }

    private func bind() {
        let output = viewModel.output
        

        output.stadiumTitle
            .drive(onNext: { [weak self] title in
                guard let self = self else { return }

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.minimumLineHeight = 22
                paragraphStyle.maximumLineHeight = 22
                paragraphStyle.alignment = .center

                self.stadiumLabel.attributedText = NSAttributedString(
                    string: title,
                    attributes: [
                        .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 17)!,
                        .foregroundColor: UIColor.gray08,
                        .paragraphStyle: paragraphStyle,
                        .kern: 0
                    ]
                )
            })
            .disposed(by: disposeBag)

        

        output.temperatureText
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }

                let paragraph = NSMutableParagraphStyle()
                paragraph.minimumLineHeight = 80
                paragraph.alignment = .center

                self.tempLabel.attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 80, weight: .thin),
                        .foregroundColor: UIColor.appBlack,
                        .paragraphStyle: paragraph,
                        .kern: -2
                    ]
                )
            })
            .disposed(by: disposeBag)

        

        output.rainText
            .drive(rainLabel.rx.text)
            .disposed(by: disposeBag)

        output.humidityText
            .drive(humidityLabel.rx.text)
            .disposed(by: disposeBag)

        output.windText
            .drive(windLabel.rx.text)
            .disposed(by: disposeBag)
        

        stadiumTapArea.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showStadiumSelect()
            }
            .disposed(by: disposeBag)
    }
}

