import Foundation
import RxSwift
import RxRelay



final class SelectGameViewModel {
    
    private let disposeBag = DisposeBag()
    
    let gameListRelay = BehaviorRelay<[SelectGameCellModel]>(value: [])
    private let gameService: RecordGameInfoService
    
    let selectedGame = PublishSubject<SelectGameCellModel>()
    
    private let mySelectedTeam: TeamInfo
    private let extraTeams: [TeamExtra]
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    init(selectedTeam: TeamInfo, extraTeams: [TeamExtra], gameService: RecordGameInfoService) {
        self.mySelectedTeam = selectedTeam
        self.extraTeams = extraTeams
        self.gameService = gameService
    }
    
    func fetchGameList() {
        isLoading.accept(true)
        Task {
            let gameInfos = await gameService.fetchGames(for: mySelectedTeam.id)
            let cellModels = gameInfos.map(transformToCellModel)
            
            DispatchQueue.main.async{
                self.gameListRelay.accept(cellModels)
                self.isLoading.accept(false)
            }
        }
    }
    
    private func transformToCellModel(_ gameInfo: GameInfoResponse) -> SelectGameCellModel {
        let homeTeam = gameInfo.teams.home
        let awayTeam = gameInfo.teams.away
        
        
        let homeTeamInfo = extraTeams.first { $0.teamId == homeTeam.name.rawValue }
        let awayTeamInfo = extraTeams.first { $0.teamId == awayTeam.name.rawValue }
        
        let opposingTeamData: TeamsAway
        if mySelectedTeam.name == homeTeam.name.rawValue {
            opposingTeamData = awayTeam
        } else {
            opposingTeamData = homeTeam
        }
        
        let opposingTeamInfo = extraTeams.first { $0.teamId == opposingTeamData.name.rawValue }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let dateString = dateFormatter.string(from: gameInfo.date)
        
        let scoreString: String
        
        var isGameCancelled = false
        
        switch gameInfo.status.short {
            
        case .ft:
            scoreString = "\(gameInfo.scores.away.total ?? 0) : \(gameInfo.scores.home.total ?? 0)"
            isGameCancelled = false
            
        case .canc, .post:
            scoreString = "경기 취소"
            isGameCancelled = true
            
        }
        
        let homeTeamTransName = BaseBallNameTranslator.getKoreanName(for: gameInfo.teams.home.name.rawValue)
        let awayTeamTransName = BaseBallNameTranslator.getKoreanName(for: gameInfo.teams.away.name.rawValue)
        
        return SelectGameCellModel(
            
            myTeamName: BaseBallNameTranslator.getKoreanName(for: mySelectedTeam.name),
            myTeamLogo: mySelectedTeam.listCharacter,
            
            
            opposingTeamName: BaseBallNameTranslator.getKoreanName(for: opposingTeamData.name.rawValue),
            opposingTeamLogo: opposingTeamInfo?.listCharacter ?? opposingTeamData.logo,
            
            homeTeamName: homeTeamTransName,
            awayTeamName: awayTeamTransName,
            
            homeTeamLogo: homeTeamInfo?.listCharacter ?? homeTeam.logo,
            awayTeamLogo: awayTeamInfo?.listCharacter ?? awayTeam.logo,
            
            homeTeamID: gameInfo.teams.home.id,
            awayTeamID: gameInfo.teams.away.id,
            
            homeTeamScore: gameInfo.scores.home.total ?? 0,
            awayTeamScore: gameInfo.scores.away.total ?? 0,
            
            
            gameDate: dateString,
            score: scoreString,
            stadium: homeTeamInfo?.stadium ?? "정보 없음",
            isCancelled: isGameCancelled
        )
    }
}
