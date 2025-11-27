import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class HomeViewModel {
    
    // Input
    let stadiumSelected: AnyObserver<StadiumInfo>
    
    // Output
    struct Output {
        let teamName: Driver<String>
        let cityName: Driver<String>
        let stadiumTitle: Driver<String>
        
        let temperatureText: Driver<String>
        let rainText: Driver<String>
        let humidityText: Driver<String>
        let windText: Driver<String>
        
        let weatherIconName: Driver<String>
        let customSentence: Driver<String>
        
        let teamMascotAssetName: Driver<String>
        
        // UI에서 쓸 예보리스트 아웃풋
        let forecastList: Driver<[StadiumForecast]>
    }
    
    // ViewController가 구독할 아웃풋
    lazy var output: Output = makeOutput()
    
    
    // 프라이빗 릴레이
    private let selectedTeamRelay: BehaviorRelay<TeamInfo>
    private let selectedStadiumRelay: BehaviorRelay<StadiumInfo>
    private let stadiumWeatherRelay = BehaviorRelay<StadiumWeather?>(value: nil)
    private let stadiumForecastRelay = BehaviorRelay<[StadiumForecast]>(value: [])

    // Input으로 들어온 구장 선택 이벤트를 받는 Subject
    private let stadiumSelectedSubject = PublishSubject<StadiumInfo>()
    
    
    private let weatherService: WeatherServiceProtocol
    private let disposeBag = DisposeBag()
    
    
    
    init(
        team: TeamInfo,
        weatherService: WeatherServiceProtocol = WeatherService()
    ) {
        self.weatherService = weatherService
        
        // Input 연결
        self.stadiumSelected = stadiumSelectedSubject.asObserver()
        
        // 관심구단 초기 상태
        self.selectedTeamRelay = BehaviorRelay(value: team)
        
        // 초기 구장은 관심구단 기본 홈구장
        self.selectedStadiumRelay = BehaviorRelay(
            value: StadiumInfo(
                name: team.stadium,
                city: team.city,
                latitude: team.location.latitude,
                longitude: team.location.longitude
            )
        )
        
        // Input -> selectedStadiumRelay로 전달
        stadiumSelectedSubject
            .bind(to: selectedStadiumRelay)
            .disposed(by: disposeBag)
        
        
        // selectedStadium 값이 바뀔 때마다 새 좌표로 날씨 자동 fetch함
        selectedStadiumRelay
            .asObservable()
            .flatMapLatest { [weak self] stadium -> Observable<StadiumWeather?> in
                guard let self = self else { return .just(nil) }
                
                return self.weatherService.fetchWeather(
                    lat: stadium.latitude,
                    lon: stadium.longitude
                )
                .map { Optional($0) }      // StadiumWeather? 형태
                .asObservable()
                .catchAndReturn(nil)        // 에러 시 nil을 반환함
            }
            .bind(to: stadiumWeatherRelay)
            .disposed(by: disposeBag)
        
        // selectedStadium 값이 바뀔 때마다 해당 구장 일기예보도 같이 fetch
        selectedStadiumRelay
            .asObservable()
            .flatMapLatest { [weak self] stadium -> Observable<[StadiumForecast]> in
                guard let self = self else { return .just([]) }

                return self.weatherService.fetchForecast(
                    lat: stadium.latitude,
                    lon: stadium.longitude
                )
                .asObservable()
                .catchAndReturn([])   // 에러 시 빈 배열
            }
            .bind(to: stadiumForecastRelay)
            .disposed(by: disposeBag)

    }
    
    
    
    private func makeOutput() -> Output {
        
        let teamNameDriver = selectedTeamRelay
            .map { $0.name }
            .asDriver(onErrorJustReturn: "")
        
        let cityNameDriver = selectedTeamRelay
            .map { $0.city }
            .asDriver(onErrorJustReturn: "")
        
        let stadiumTitleDriver = selectedStadiumRelay
            .map { stadium in
                "\(stadium.name)"
            }
            .asDriver(onErrorJustReturn: "-")
        
        let weatherDriver = stadiumWeatherRelay.asDriver()
        
        let forecastListDriver = stadiumForecastRelay
            .asDriver(onErrorJustReturn: [])
        
        let temperatureTextDriver = weatherDriver
            .map { weather -> String in
                guard let currentWeather = weather else {
                    return "구장 온도 정보를 불러오는 중"
                }
                let temp = String(format: "%.1f", currentWeather.temperatureC)
                return "\(temp)°"
            }
        
        let rainTextDriver = weatherDriver
            .map { weather -> String in
                guard let currentWeather = weather else {
                    return "강수량 정보를 불러오는 중"
                }
                let rain = currentWeather.precipitation ?? 0
                return "\(rain)mm"
            }
        
        let humidityTextDriver = weatherDriver
            .map { weather -> String in
                guard let currentWeather = weather else {
                    return "습도 정보를 불러오는 중"
                }
                return "\(currentWeather.humidity)%"
            }
        
        let windTextDriver = weatherDriver
            .map { weather -> String in
                guard let currentWeather = weather else {
                    return "현재 구장 풍속 정보를 불러오는 중"
                }
                return "\(currentWeather.windSpeed)m/s"
            }
        
        let weatherIconDriver = weatherDriver
            .map { [weak self] weather -> String in
                guard
                    let self = self,
                    let currentWeather = weather
                else {
                    return "clearSkyEmoji"
                }
                return self.emojiAssetName(for: currentWeather.description)
            }
        
        let customSentenceDriver = weatherDriver
            .map { [weak self] weather -> String in
                guard
                    let self = self,
                    let currentWeather = weather
                else {
                    return ""
                }
                return self.customSentence(for: currentWeather.description)
            }

        let teamMascotAssetNameDriver = selectedTeamRelay
            .map { $0.defaultCharacter }
            .asDriver(onErrorJustReturn: "")
        
        return Output(
            teamName: teamNameDriver,
            cityName: cityNameDriver,
            stadiumTitle: stadiumTitleDriver,
            temperatureText: temperatureTextDriver,
            rainText: rainTextDriver,
            humidityText: humidityTextDriver,
            windText: windTextDriver,
            weatherIconName: weatherIconDriver,
            customSentence: customSentenceDriver,
            teamMascotAssetName: teamMascotAssetNameDriver,
            forecastList: forecastListDriver
        )
    }
    
    private func emojiAssetName(for description: String) -> String {
        switch description.lowercased() {
        case "clear sky":
            return "clearSkyEmoji"
        case "few clouds":
            return "fewCloudsEmoji"
        case "scattered clouds":
            return "scatteredCloudsEmoji"
        case "broken clouds":
            return "brokenCloudsEmoji"
        case "shower rain":
            return "showerRainEmoji"
        case "rain":
            return "rainEmoji"
        case "thunderstorm":
            return "thunderStormEmoji"
        case "snow":
            return "snowEmoji"
        case "mist":
            return "mistEmoji"
        default:
            return "clearSkyEmoji"
        }
    }

    private func customSentence(for description: String) -> String {
            switch description.lowercased() {
            case "clear sky":
                return "완벽한 야구 관람일이에요!"

            case "few clouds":
                return "시원하게 보기 좋은 날이에요!"

            case "scattered clouds":
                return "햇빛 부담 없이 관람할 수 있어요!"

            case "broken clouds":
                return "조금 어둡지만 관람에 큰 지장은 없어요!"

            case "shower rain":
                return "비가 와요, 우산 꼭 챙겨주세요!"

            case "rain":
                return "관람이 어려워요, 경기 일정 확인 필수!"

            case "thunderstorm":
                return "번개 주의! 경기 일정 꼭 확인해주세요!"

            case "snow":
                return "눈이 내려요, 따뜻하게 입고 관람하세요!"

            case "mist":
                return "안개가 껴요, 시야가 흐릴 수 있어요!"

            default:
                return "완벽한 야구 관람일이에요!"
            }
        }

}

