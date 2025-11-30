import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class ScheduleViewModel {
    private let scheduleService: ScheduleService
    private let disposeBag = DisposeBag()
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    
    private let allGames = BehaviorRelay<[Game]>(value: [])
    let gameDatesForCalendar = BehaviorRelay<Set<String>>(value: Set())

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
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] games in
                guard let self = self else { return }
                self.allGames.accept(games)
                
                // dot 표시 용 날짜 set
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
                let dateSet = Set(games.map { dateFormatter.string(from: $0.date) })
                self.gameDatesForCalendar.accept(dateSet)
            })
            .disposed(by: disposeBag)
    }
}
