import Foundation
import RxRelay
import RxSwift


final class RecordViewModel {
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    let gameInfoResults = BehaviorRelay<[GameInfoResponse]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(team: TeamInfo){
        self.selectedTeam = BehaviorRelay(value: team)
    }
    func loadMergeData(){
        Task {
            var collectGames: [GameInfoResponse] = []
            guard var targetdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {return}
            let selectTeamID = selectedTeam.value.id
            
            // 배포 삭제 데이터 ================
            var dummyDate = DateComponents()
            dummyDate.year = 2025
            dummyDate.month = 03
            dummyDate.day = 27
            let dummyDates = Calendar.current.date(from: dummyDate)
            guard var yesterdayDummyDates = Calendar.current.date(byAdding: .day, value: -1, to: dummyDates!) else {return}
            // =============================
            
            //yesterdayDummyDates -> targetdayDate로 변경(배포시)
            while collectGames.count < 5 {
                let newGames = await RecordService.shared.fetchGames(teamId: selectTeamID, date: yesterdayDummyDates)
                
                if !newGames.isEmpty{
                    collectGames.append(contentsOf: newGames)
                }
                
                
                guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: yesterdayDummyDates) else {return}
                yesterdayDummyDates = yesterdayDate
                
            }
            let fiveGames = Array(collectGames.sorted{$0.timestamp > $1.timestamp}.prefix(5))
            
            await MainActor.run{
                self.gameInfoResults.accept(fiveGames)
            }
        }
    }
}
