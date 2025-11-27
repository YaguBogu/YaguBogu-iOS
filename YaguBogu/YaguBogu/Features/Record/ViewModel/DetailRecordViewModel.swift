
import RxSwift
import RxRelay
import RxCocoa


final class DetailRecordViewModel{
    
    let data: RecordData
    private var disposeBag = DisposeBag()
    
    let title: String?
    let gameDate: String?
    let matchTeamText: String
    let stadiumName: String?
    let contentText: String?
    let matchResult: DetailMatchResult
    
    init(data: RecordData){
        self.data = data
        self.title = data.title
        self.gameDate = data.gameDate
        self.stadiumName = data.stadium
        self.contentText = data.contentText
        
        let homeTeam = data.homeTeam ?? "홈팀"
        let awayTeam = data.awayTeam ?? "원정팀"
        self.matchTeamText = "\(homeTeam) vs \(awayTeam)"
        
        self.matchResult = DetailMatchResult(home: data.homeScore, away: data.awayScore)
        bind()
    }
    
    private func bind(){
        
    }
}
