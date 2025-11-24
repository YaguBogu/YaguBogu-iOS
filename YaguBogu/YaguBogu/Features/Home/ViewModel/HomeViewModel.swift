import Foundation
import RxRelay

class HomeViewModel {
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    
    // 스타디움웨더 모델 값 담아둘 프로퍼티
    let stadiumWeather = BehaviorRelay<StadiumWeather?>(value: nil)
    
    init(team: TeamInfo) {
        self.selectedTeam = BehaviorRelay(value: team)
    }
}
