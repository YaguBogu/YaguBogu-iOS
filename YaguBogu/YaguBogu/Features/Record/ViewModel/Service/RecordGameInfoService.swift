import Foundation

final class RecordGameInfoService {

    func fetchGames(for teamId: Int) async -> [GameInfoResponse] {
        var collectGames: [GameInfoResponse] = []
        let selectTeamID = teamId
        
        guard let targetdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            return []
        }
        
        // ================ 테스트용 더미 데이터 ================
        var dummyDate = DateComponents()
        dummyDate.year = 2025
        dummyDate.month = 03
        dummyDate.day = 27
        let dummyDates = Calendar.current.date(from: dummyDate)!
        var yesterdayDummyDates = Calendar.current.date(byAdding: .day, value: -1, to: dummyDates)!
        // =====================================================
        
        
        //yesterdayDummyDates -> targetdayDate로 변경(배포시)
        while collectGames.count < 5 {
            let newGames = await RecordService.shared.fetchData(teamId: selectTeamID, date: yesterdayDummyDates)
            
            if !newGames.isEmpty {
                collectGames.append(contentsOf: newGames)
            }
            
            guard let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: yesterdayDummyDates) else {
                break
            }
            yesterdayDummyDates = yesterdayDate
        }
        
        let fiveGames = Array(collectGames.sorted { $0.timestamp > $1.timestamp }.prefix(5))
        
        return fiveGames
    }
}
