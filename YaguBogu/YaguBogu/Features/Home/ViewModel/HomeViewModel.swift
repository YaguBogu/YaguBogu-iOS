import Foundation
import RxRelay

class HomeViewModel {
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    
    
    init(team: TeamInfo) {
        self.selectedTeam = BehaviorRelay(value: team)
    }
}
