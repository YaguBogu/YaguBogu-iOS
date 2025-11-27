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
    
    private let windIcon = UIImageView(image: UIImage(named: "windIcon"))
    private let rainIcon = UIImageView(image: UIImage(named: "rainIcon"))
    private let dropIcon = UIImageView(image: UIImage(named: "rainDropIcon"))
    
    private let weatherEmoji = UIImageView()
    private let emojiBox = UIView()
    private let customWeatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
        label.textColor = .appBlack
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()
    private let emojiStack = UIStackView()

    private let mascotBox = UIView()
    private let mascotImageView = UIImageView()

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
        //headerContainer.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        
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
        //weatherContainer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
        
        weatherContainer.addSubview(tempLabel)
        
        windIcon.contentMode = .center
        rainIcon.contentMode = .center
        dropIcon.contentMode = .center
        
        rightStack.axis = .vertical
        rightStack.spacing = 6
        rightStack.alignment = .trailing
        rightStack.distribution = .equalSpacing
        
        // 수평 스택 3개 만들기
        let windRow = UIStackView(arrangedSubviews: [windIcon, windLabel])
        windRow.axis = .horizontal
        windRow.spacing = 11
        windRow.alignment = .center

        let rainRow = UIStackView(arrangedSubviews: [rainIcon, rainLabel])
        rainRow.axis = .horizontal
        rainRow.spacing = 11
        rainRow.alignment = .center

        let humidityRow = UIStackView(arrangedSubviews: [dropIcon, humidityLabel])
        humidityRow.axis = .horizontal
        humidityRow.spacing = 11
        humidityRow.alignment = .center
        
        // 라벨이 늘어날 때 왼쪽으로 늘어나게 하기
        windLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        rainLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        humidityLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        // rightStack 설정
        rightStack.axis = .vertical
        rightStack.spacing = 6
        rightStack.alignment = .leading
        rightStack.distribution = .equalSpacing

        // 세 개의 row 막대기를 rightStack에 넣기
        rightStack.addArrangedSubview(windRow)
        rightStack.addArrangedSubview(rainRow)
        rightStack.addArrangedSubview(humidityRow)

        
        weatherContainer.addSubview(rightStack)
        
        //emojiBox.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
        view.addSubview(emojiBox)
        
        // 스택뷰 설정 (세로 정렬)
        emojiStack.axis = .vertical
        emojiStack.alignment = .center
        emojiStack.spacing = 12
        
        // 이모지 이미지 뷰 설정
        weatherEmoji.contentMode = .scaleAspectFit
        
        // 스택뷰를 emojiBox 안에 넣고, 그 안에 이모지+라벨 넣기
        emojiBox.addSubview(emojiStack)
        emojiStack.addArrangedSubview(weatherEmoji)
        emojiStack.addArrangedSubview(customWeatherLabel)

        // 팀 마스코트 박스
        mascotBox.backgroundColor = .clear
        view.addSubview(mascotBox)

        mascotImageView.contentMode = .scaleAspectFit
        mascotBox.addSubview(mascotImageView)

        
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
        
        // weatherContainer 아래 투명박스 (375 × 166)
        emojiBox.snp.makeConstraints { make in
            make.top.equalTo(weatherContainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(166)
        }
        
        // 팀 마스코트 박스 (375 x 300)
        mascotBox.snp.makeConstraints { make in
            make.top.equalTo(emojiBox.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        // 마스코트 이미지뷰 (280 x 280)
        mascotImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(300)
        }

        // 이모지 + 문구가 들어있는 스택뷰를 emojiBox 중앙에 배치
        emojiStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        // 이모지 사이즈만 지정
        weatherEmoji.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }

        
        tempLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(170) // 원래 114인데, 잘려서 늘림
            make.height.equalTo(80)
        }
        
        rightStack.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.height.equalTo(66)
        }
        
        windIcon.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }

        rainIcon.snp.makeConstraints { make in
            make.width.height.equalTo(18)
        }

        dropIcon.snp.makeConstraints { make in
            make.width.height.equalTo(18)
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
                paragraph.alignment = .left

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
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }

                let paragraph = NSMutableParagraphStyle()
                paragraph.minimumLineHeight = 18
                paragraph.maximumLineHeight = 18
                paragraph.alignment = .center

                self.rainLabel.attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray09,
                        .paragraphStyle: paragraph,
                        .kern: 0
                    ]
                )
            })
            .disposed(by: disposeBag)


        output.humidityText
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }

                let paragraph = NSMutableParagraphStyle()
                paragraph.minimumLineHeight = 18
                paragraph.maximumLineHeight = 18
                paragraph.alignment = .center

                self.humidityLabel.attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray09,
                        .paragraphStyle: paragraph,
                        .kern: 0
                    ]
                )
            })
            .disposed(by: disposeBag)


        output.windText
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }

                let paragraph = NSMutableParagraphStyle()
                paragraph.minimumLineHeight = 18
                paragraph.maximumLineHeight = 18
                paragraph.alignment = .center

                self.windLabel.attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray09,
                        .paragraphStyle: paragraph,
                        .kern: 0
                    ]
                )
            })
            .disposed(by: disposeBag)
        
        output.weatherIconName
            .drive(onNext: { [weak self] iconName in
                self?.weatherEmoji.image = UIImage(named: iconName)
            })
            .disposed(by: disposeBag)
        
        output.customSentence
            .drive(onNext: { [weak self] text in
                guard let self = self else { return }

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.minimumLineHeight = 22
                paragraphStyle.maximumLineHeight = 22
                paragraphStyle.alignment = .center

                self.customWeatherLabel.attributedText = NSAttributedString(
                    string: text,
                    attributes: [
                        .font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)!,
                        .foregroundColor: UIColor.appBlack,
                        .paragraphStyle: paragraphStyle,
                        .kern: 0
                    ]
                )
            })
            .disposed(by: disposeBag)

        output.teamMascotAssetName
            .drive(onNext: { [weak self] assetName in
                guard let self = self else { return }
                self.mascotImageView.image = UIImage(named: assetName)
            })
            .disposed(by: disposeBag)

        

        stadiumTapArea.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showStadiumSelect()
            }
            .disposed(by: disposeBag)

    }
}

