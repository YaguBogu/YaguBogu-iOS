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
            do{
                // 배포 시 지울 데이터들 ==========
                let clock = ContinuousClock()
                let duration = try? await clock.measure {
                    
                    
                    var dummyDate = DateComponents()
                    dummyDate.year = 2025
                    dummyDate.month = 03
                    dummyDate.day = 27
                    guard let dummyDates = Calendar.current.date(from: dummyDate) else {return}
                    var yesterdayDummyDates = Calendar.current.date(byAdding: .day, value: -1, to: dummyDates)!
                    
                    // ===========================
                    var collectGames: [GameInfoResponse] = []
                    var yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
                    let selectTeamID = selectedTeam.value.id
                    
                    while collectGames.count < 5{
                        
                        //dummyDates -> yesterdayDate로 바꿔야함
                        let dateString = dateToString(yesterdayDummyDates)
                        let year = Calendar.current.component(.year, from: yesterdayDummyDates)
                        guard let url = URL(string: "https://v1.baseball.api-sports.io/games?league=5&season=\(year)&team=\(selectTeamID)&date=\(dateString)") else {continue}
                        
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET"
                        request.setValue(Secrets.$BaseballApiKey, forHTTPHeaderField: "x-rapidapi-key")
                        
                        if let (data, _) = try? await URLSession.shared.data(for: request){
                            let decoder = JSONDecoder()
                            decoder.dateDecodingStrategy = .iso8601
                            let newGames = (try? decoder.decode(GameInfo.self, from: data))?.response ?? []
                            
                            if !newGames.isEmpty {
                                collectGames.append(contentsOf: newGames)
                            }
                        }
                        yesterdayDummyDates = Calendar.current.date(byAdding: .day, value: -1, to: yesterdayDummyDates)!
                    }
                    
                    let fiveGames = Array(collectGames.sorted{$0.timestamp > $1.timestamp}.prefix(5))
                    for (index, gameInfo) in fiveGames.prefix(5).enumerated(){
                        let homeTeam = gameInfo.teams.home.name
                        let awayTeam = gameInfo.teams.away.name
                        let score = "\(gameInfo.scores.home.total ?? 0) : \(gameInfo.scores.away.total ?? 0)"
                        
                        print("[\(index)]: ID(\(gameInfo.id)) | \(gameInfo.date) | \(homeTeam) vs \(awayTeam) | 최종스코어: \(score)")
                    }
                    await MainActor.run{
                        self.gameInfoResults.accept(fiveGames)
                    }
                    
                }
                if let duration = duration {
                    let seconds = Double(duration.components.seconds) + Double(duration.components.attoseconds) / 1_000_000_000_000_000_000
                    print(String(format: "소요 시간: %.3f초", seconds))
                }
            }
        }
        
        func dateToString(_ date: Date) -> String{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
    }
}
