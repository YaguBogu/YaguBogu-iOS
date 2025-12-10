
import RxSwift

final class DetailRecordViewModel{
    
    let data: RecordData
    
    let title: String?
    let gameDate: String?
    let matchTeamText: String
    let stadiumName: String?
    let contentText: String?
    let photoData: String?
    let matchResult: DetailMatchResult
    
    init(data: RecordData){
        self.data = data
        self.title = data.title
        self.gameDate = data.gameDate
        self.stadiumName = data.stadium
        self.contentText = data.contentText
        self.photoData = data.photoData
        
        let homeTeam = data.homeTeam ?? "홈팀"
        let awayTeam = data.awayTeam ?? "원정팀"
        self.matchTeamText = "\(awayTeam) vs \(homeTeam)"
        
        let myTeamId = Int(data.myTeamId)
        let homeTeamId = Int(data.homeTeamId)
        let awayTeamId = Int(data.awayTeamId)
        let homeScore = Int(data.homeScore)
        let awayScore = Int(data.awayScore)
        
        
        if let result = DetailMatchResult(myTeamId: myTeamId, homeTeamId: homeTeamId, awayTeamId: awayTeamId, homeScore: homeScore, awayScore: awayScore) {
            self.matchResult = result
        } else {
            self.matchResult = .draw
        }
    }
}
