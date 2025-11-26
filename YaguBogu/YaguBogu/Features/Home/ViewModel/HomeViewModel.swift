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
    }
    
    // ViewController가 구독할 아웃풋
    lazy var output: Output = makeOutput()
    
    
    // 프라이빗 릴레이
    private let selectedTeamRelay: BehaviorRelay<TeamInfo>
    private let selectedStadiumRelay: BehaviorRelay<StadiumInfo>
    private let stadiumWeatherRelay = BehaviorRelay<StadiumWeather?>(value: nil)
    
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
        
        // 날씨 변화 스트림
        let weatherDriver = stadiumWeatherRelay.asDriver()
        
        let temperatureTextDriver = weatherDriver
            .map { weather -> String in
                guard let w = weather else {
                    return "구장 온도 정보를 불러오는 중"
                }
                let temp = String(format: "%.1f", w.temperatureC)
                return "\(temp)°"
            }
        
        let rainTextDriver = weatherDriver
            .map { weather -> String in
                guard let w = weather else {
                    return "강수량 정보를 불러오는 중"
                }
                let rain = w.precipitation ?? 0
                return "\(rain)mm"
            }
        
        let humidityTextDriver = weatherDriver
            .map { weather -> String in
                guard let w = weather else {
                    return "습도 정보를 불러오는 중"
                }
                return "\(w.humidity)%"
            }
        
        let windTextDriver = weatherDriver
            .map { weather -> String in
                guard let w = weather else {
                    return "현재 구장 풍속 정보를 불러오는 중"
                }
                return "\(w.windSpeed)m/s"
            }
        
        return Output(
            teamName: teamNameDriver,
            cityName: cityNameDriver,
            stadiumTitle: stadiumTitleDriver,
            temperatureText: temperatureTextDriver,
            rainText: rainTextDriver,
            humidityText: humidityTextDriver,
            windText: windTextDriver
        )
    }
}

