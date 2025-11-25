import UIKit
import RxSwift
import RxGesture

class HomeViewController: BaseViewController {
    
    weak var coordinator: HomeCoordinator?
    
    private let viewModel: HomeViewModel
    
    private let teamName = UILabel()
    private let cityName = UILabel()
    
    private let tempLabel = UILabel()
    private let stadiumLabel = UILabel()
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
    
    override func configureUI() {
        super.configureUI()
        [teamName, cityName, stadiumLabel, tempLabel, rainLabel, humidityLabel, windLabel]
            .forEach { view.addSubview($0) }
        
        stadiumLabel.isUserInteractionEnabled = true
        
    }

    
    override func setupConstraints() {
        super.setupConstraints()
        
        teamName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        cityName.snp.makeConstraints { make in
            make.top.equalTo(teamName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        stadiumLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        rainLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(rainLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        windLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }



    }

    
    private func bind() {
        // 팀 정보 바인딩
        viewModel.selectedTeam
            .asDriver()
            .drive(onNext: { [weak self] team in
                self?.teamName.text = team.name
                self?.cityName.text = team.city
            })
            .disposed(by: disposeBag)

        // 선택된 구장 타이틀 바인딩
        viewModel.selectedStadium
            .asDriver()
            .drive(onNext: { [weak self] info in
                self?.stadiumLabel.text = "선택된 구장: \(info.name), \(info.city)"
            })
            .disposed(by: disposeBag)
        
        
        // (관심구단의 홈구장 기준으로)날씨 바인딩
        viewModel.stadiumWeather
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] weather in
                
                // 온도
                self?.tempLabel.text = "관심구단 홈구장의 온도: \(weather.temperatureC)°C"
                // 강수량
                if let rain = weather.precipitation {
                    self?.rainLabel.text = "관심구단 홈구장의 강수량: \(rain)mm"
                } else {
                    self?.rainLabel.text = "관심구단 홈구장의 강수량: 0mm"
                }
                
                // 습도
                self?.humidityLabel.text = "관심구단 홈구장의 습도: \(weather.humidity)%"
                
                // 풍속
                self?.windLabel.text = "관심구단 홈구장의 풍속: \(weather.windSpeed)m/s"
                
            })
            .disposed(by: disposeBag)
        
        // 스타디움라벨 탭 이벤트
        stadiumLabel.rx.tapGesture()
            .when(.recognized)
            .bind { [weak self] _ in
                self?.coordinator?.showStadiumSelect()
            }
            .disposed(by: disposeBag)
    }


    
}

