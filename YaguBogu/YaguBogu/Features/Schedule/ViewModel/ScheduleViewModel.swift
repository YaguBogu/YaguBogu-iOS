import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class ScheduleViewModel {
    private let scheduleService: ScheduleService
    private let disposeBag = DisposeBag()
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    let game = BehaviorRelay<[Game]>(value: [])


    init(team: TeamInfo, scheduleService: ScheduleService = ScheduleService()) {
        self.selectedTeam = BehaviorRelay(value: team)
        self.scheduleService = scheduleService
        
        loadGames(team: team)
    }
    
    private func loadGames(team: TeamInfo) {
        scheduleService.fetchSchedule(for: team.id, year: 2025)
            .map { items in
                items.compactMap { $0.toGame(for: team.id) }
            }
            .bind(to: game)
            .disposed(by: disposeBag)
    }
}
