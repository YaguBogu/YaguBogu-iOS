import UIKit
import RxSwift
import RxGesture
import RxCocoa
import SnapKit
import Gifu

class HomeViewController: BaseViewController {
    
    let retapEvent = PublishRelay<Void>()
    
    weak var coordinator: HomeCoordinator?
    
    private let viewModel: HomeViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let refreshControl = UIRefreshControl()

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
    private let mascotImageView = GIFImageView()

    private let infoContainer = UIView()
    private let forecastBox = UIView()

    private let forecastTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        label.textColor = .appBlack
        label.text = "시간대별 날씨"
        

        let paragraph = NSMutableParagraphStyle()
        paragraph.minimumLineHeight = 21
        paragraph.maximumLineHeight = 21
        paragraph.alignment = .left
        
        label.attributedText = NSAttributedString(
            string: "시간대별 날씨",
            attributes: [
                .font: UIFont(name: "AppleSDGothicNeo-Medium", size: 16)!,
                .foregroundColor: UIColor.appBlack,
                .paragraphStyle: paragraph
            ]
        )
        return label
    }()
    private let forecastStack = UIStackView()
    
    private let stadiumLocationView = StadiumLocationView()
    
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
        bindRetap()
        
        if let tab = self.tabBarController as? TabBarController {
            tab.homeTabReselected
                .bind(to: retapEvent)
                .disposed(by: disposeBag)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func configureUI() {
        super.configureUI()
        
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerLogoImageView)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stadiumTapArea)
        stadiumTapArea.addSubview(stadiumLabel)
        stadiumTapArea.addSubview(downIcon)
        stadiumTapArea.isUserInteractionEnabled = true
        

        stadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 17)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.alignment = .center

        

        contentView.addSubview(weatherContainer)
        
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
        
        contentView.addSubview(emojiBox)
        
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
        contentView.addSubview(mascotBox)

        mascotImageView.contentMode = .scaleAspectFit
        mascotBox.addSubview(mascotImageView)
        
        // infoContainer 추가 (일기예보 + 구장위치 박스 영역)
        contentView.addSubview(infoContainer)

        forecastBox.addSubview(forecastTitleLabel)
        forecastBox.addSubview(forecastStack)

        forecastBox.backgroundColor = .white
        forecastBox.layer.cornerRadius = 20
        forecastBox.layer.masksToBounds = false


        forecastBox.layer.shadowColor = UIColor(red: 1, green: 114/255, blue: 116/255, alpha: 1).cgColor
        forecastBox.layer.shadowOpacity = 0.04
        forecastBox.layer.shadowOffset = CGSize(width: 4, height: 4)
        forecastBox.layer.shadowRadius = 4

        
        infoContainer.addSubview(forecastBox)
        infoContainer.addSubview(stadiumLocationView)

        // 일기예보 스택
        forecastBox.addSubview(forecastStack)
        forecastStack.axis = .horizontal
        forecastStack.alignment = .center
        forecastStack.distribution = .equalCentering   
        forecastStack.spacing = 25.75

        // 스크롤뷰 제스처 허용
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        
        scrollView.refreshControl = refreshControl
    }

    override func setupConstraints() {
        super.setupConstraints()
        

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerContainer.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }

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
            make.top.equalTo(contentView.snp.top)
            make.leading.trailing.equalTo(contentView)
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
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(100)
        }
        
        emojiBox.snp.makeConstraints { make in
            make.top.equalTo(weatherContainer.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(166)
        }
        
        // 팀 마스코트 박스 (375 x 300)
        mascotBox.snp.makeConstraints { make in
            make.top.equalTo(emojiBox.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(300)
        }
        
        // 인포컨테이너(일기예보랑 구장위치) (375 x 476)
        infoContainer.snp.makeConstraints { make in
            make.top.equalTo(mascotBox.snp.bottom)
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(476)
            make.bottom.equalToSuperview()
        }
        
        // 일기예보 영역 (343 x 162)
        forecastBox.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(162)
        }
        
        forecastTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(22)   
            make.leading.equalToSuperview().offset(20)
        }

        forecastStack.snp.makeConstraints { make in
            make.top.equalTo(forecastTitleLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(22)
        }


        // 구장위치 영역 (343 x 268)
        stadiumLocationView.snp.makeConstraints { make in
            make.top.equalTo(forecastBox.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(268)
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
            make.width.equalTo(180) 
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

    private func openNaverMapForCurrentStadium() {
            let stadium = viewModel.currentStadiumInfo()

            let lat = stadium.latitude
            let lon = stadium.longitude
            let name = stadium.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

            guard
                let appURL = URL(string: "nmap://place?lat=\(lat)&lng=\(lon)&name=\(name)"),
                let webURL = URL(string: "https://map.naver.com/v5/search/\(name)")
            else {
                print("URL 생성 실패")
                return
            }

            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else {
                UIApplication.shared.open(webURL)
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
                        .font: UIFont(name: "SFProText-Thin", size: 80) ?? UIFont.systemFont(ofSize: 80, weight: .thin),
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
                        .font: UIFont(name: "SFProText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray08,
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
                        .font: UIFont(name: "SFProText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray08,
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
                        .font: UIFont(name: "SFProText-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium),
                        .foregroundColor: UIColor.gray08,
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
            .drive(onNext: { [weak self] fileName in
                guard let self = self else { return }

                guard let url = Bundle.main.url(forResource: fileName, withExtension: "gif"),
                      let data = try? Data(contentsOf: url) else {
                    print("GIF 파일을 찾지 못함: \(fileName).gif")
                    return
                }

                self.mascotImageView.animate(withGIFData: data)
            })
            .disposed(by: disposeBag)



        output.stadiumAddress
            .drive(onNext: { [weak self] address in
                self?.stadiumLocationView.updateAddress(address)
            })
            .disposed(by: disposeBag)

        stadiumTapArea.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showStadiumSelect()
            }
            .disposed(by: disposeBag)

        stadiumLocationView.rx.tapGesture()
                    .when(.recognized)
                    .bind { [weak self] _ in
                        self?.openNaverMapForCurrentStadium()
                    }
                    .disposed(by: disposeBag)

        stadiumLocationView.openButton.rx.tap
            .bind { [weak self] in
                self?.openNaverMapForCurrentStadium()
            }
            .disposed(by: disposeBag)

        
        output.forecastList
            .drive(onNext: { [weak self] list in
                guard let self = self else { return }

                self.forecastStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

                for forecast in list {
                    let hourString = String(forecast.dateTimeText.split(separator: " ")[1].prefix(2))
                    let hourInt = Int(hourString) ?? 0
                    let time = "\(hourInt)시"

                    let iconName = self.viewModel.emojiAssetName(for: forecast.description)
                    let tempInt = Int(forecast.temperatureC)

                    let itemView = ForecastItemView()
                    itemView.configure(time: time, iconName: iconName, temp: tempInt)

                    itemView.snp.makeConstraints { make in
                        make.width.equalTo(40)
                        make.height.equalTo(83)
                    }

                    self.forecastStack.addArrangedSubview(itemView)
                }
            })
            .disposed(by: disposeBag)

        output.stadiumAddress
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                let stadium = self.viewModel.currentStadiumInfo()
                self.stadiumLocationView.updateMapLocation(
                    lat: stadium.latitude,
                    lon: stadium.longitude
                )
            })
            .disposed(by: disposeBag)
        
        // 새로고침
        refreshControl.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                guard let self = self else { return }
                let current = self.viewModel.currentStadiumInfo()
                self.viewModel.stadiumSelected.onNext(current)
            }
            .disposed(by: disposeBag)

        // 새로고침 종료
        viewModel.output.temperatureText
            .drive(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

    }
    
    private func bindRetap() {
        retapEvent
            .asSignal()
            .emit(onNext: { [weak self] in
                guard let self = self else { return }

                self.scrollView.setContentOffset(.zero, animated: true)
            })
            .disposed(by: disposeBag)
        
    }

}

