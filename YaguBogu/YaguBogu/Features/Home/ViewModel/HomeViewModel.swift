import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    let stadiumWeather = BehaviorRelay<StadiumWeather?>(value: nil)

    private let weatherService: WeatherServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(
        team: TeamInfo,
        weatherService: WeatherServiceProtocol = WeatherService()
    ) {
        self.selectedTeam = BehaviorRelay(value: team)
        self.weatherService = weatherService
        
        // 홈 화면 들어오면 자동으로 현재 날씨 받아옴
        fetchWeather()
    }
    
    private func fetchWeather() {
        let team = selectedTeam.value
        
        // 관심구단의 홈구장 위치 (위도,경도)
        let lat = team.location.latitude
        let lon = team.location.longitude
        
        weatherService.fetchWeather(lat: lat, lon: lon)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] weather in
                self?.stadiumWeather.accept(weather)
            }, onFailure: { error in
                // 디버깅 필요하면 여기에 프린트문 추가해서 확인해보기
            })
            .disposed(by: disposeBag)

    }
}

