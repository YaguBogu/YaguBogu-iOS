import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    let selectedStadium: BehaviorRelay<String>
    
    let stadiumWeather = BehaviorRelay<StadiumWeather?>(value: nil)

    private let weatherService: WeatherServiceProtocol
    private let disposeBag = DisposeBag()
    
    init(
        team: TeamInfo,
        weatherService: WeatherServiceProtocol = WeatherService()
    ) {
        // 관심구단은 그대로 릴레이에 보관해줌
        self.selectedTeam = BehaviorRelay(value: team)
        
        // 홈 화면에서 처음에 보여줄 구장은 '관심구단의 기본 홈구장'
        self.selectedStadium = BehaviorRelay(value: team.stadium)
        
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
    
    // 홈코디네이터에서 호출되는 함수
    func updateSelectedStadium(name: String) {
        selectedStadium.accept(name)
    }
}

