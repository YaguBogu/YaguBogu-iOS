import UIKit
import RxSwift

class HomeViewController: BaseViewController {
    
    private let viewModel: HomeViewModel
    
    private let teamName = UILabel()
    private let cityName = UILabel()
    
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
        [teamName, cityName, stadiumLabel, rainLabel, humidityLabel, windLabel]
            .forEach { view.addSubview($0) }
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
        
        stadiumLabel.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        rainLabel.snp.makeConstraints { make in
            make.top.equalTo(stadiumLabel.snp.bottom).offset(8)
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
                self?.stadiumLabel.text = team.stadium
            })
            .disposed(by: disposeBag)


        
        // 날씨 바인딩 추가
        viewModel.stadiumWeather
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] weather in
                
                // 강수량
                if let rain = weather.precipitation {
                    self?.rainLabel.text = "강수량: \(rain)mm"
                } else {
                    self?.rainLabel.text = "강수량: 0mm"
                }
                
                // 습도
                self?.humidityLabel.text = "습도: \(weather.humidity)%"
                
                // 풍속
                self?.windLabel.text = "풍속: \(weather.windSpeed)m/s"
                
            })
            .disposed(by: disposeBag)


    }

    
}

