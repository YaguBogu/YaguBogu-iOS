import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class ScheduleViewModel {
    private let scheduleService: ScheduleService
    private let disposeBag = DisposeBag()
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    
    let allGames = BehaviorRelay<[Game]>(value: [])
    let gameDatesForCalendar = BehaviorRelay<Set<String>>(value: Set())
    let today20260327: Date
    
    init(team: TeamInfo, scheduleService: ScheduleService = ScheduleService()) {
        self.selectedTeam = BehaviorRelay(value: team)
        self.scheduleService = scheduleService
        self.today20260327 = Self.createDate(year: 2026, month: 3, day: 27)
        
        loadGames(team: team)
    }
    
    private func loadGames(team: TeamInfo) {
        scheduleService.fetchSchedule(for: team.id, year: 2025)
            .map { items in
                items.compactMap { $0.toGame(for: team.id) }
            }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] all2025Games in
                guard let self = self else { return }
                
                let calendar = Calendar.current
                
                // 2025.03 경기만 필터링
                let march2025Games = all2025Games.filter {
                    calendar.component(.month, from: $0.date) == 3
                }
                
                // 2025.03 -> 2026.03에 데이터 대입
                let simulatedMarch2026Games: [Game] = march2025Games.compactMap { game in
                    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: game.date)
                    components.year = 2026
                    guard let adjustedDate = calendar.date(from: components) else { return nil }
                    
                    var adjustedStatus: GameStatus = game.status
                    var adjustedResult: GameResult? = game.result
                    
                    if adjustedDate >= self.today20260327 {
                        adjustedStatus = .scheduled
                        adjustedResult = nil
                    }
                    
                    // ID 충돌 방지를 위해 +100000
                    return Game(
                        id: game.id + 100000,
                        date: adjustedDate,
                        status: adjustedStatus,
                        time: game.time,
                        awayTeamName: game.awayTeamName,
                        homeTeamName: game.homeTeamName,
                        result: adjustedResult,
                        stadiumName: game.stadiumName,
                        awayTeamCharacter: game.awayTeamCharacter,
                        homeTeamCharacter: game.homeTeamCharacter
                    )
                }
                
                // 최종 일정 병합 (2025 + 2026.03)
                let finalGames = all2025Games + simulatedMarch2026Games
                self.allGames.accept(finalGames)
                
                // 캘린더 Dot 표시 (finalGames 기준)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
                
                let dateSet = Set(finalGames.map { dateFormatter.string(from: $0.date) })
                self.gameDatesForCalendar.accept(dateSet)
            })
            .disposed(by: disposeBag)
    }
    
    private static func createDate(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.timeZone = TimeZone(identifier: "Asia/Seoul")
        return Calendar.current.date(from: components)!
    }
}
