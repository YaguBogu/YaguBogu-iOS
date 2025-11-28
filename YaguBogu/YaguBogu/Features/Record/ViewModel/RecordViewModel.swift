import Foundation
import RxRelay
import RxSwift

final class RecordViewModel {
    
    private let recordStorage: RecordCoreDataService
    private let gameInfoService: RecordGameInfoService
    
    
    let recordList = BehaviorRelay<[RecordData]>(value: [])
    let gameInfoResults = BehaviorRelay<[GameInfoResponse]>(value: [])
    let navigateToDetail = PublishSubject<RecordData>()
    let floatingButtonTapped = PublishSubject<Void>()
    let navigateToCreate = PublishSubject<Void>()
    
    let selectedTeam: BehaviorRelay<TeamInfo>
    
    
    private let disposeBag = DisposeBag()

    
    init(team: TeamInfo, recordStorage: RecordCoreDataService, gameInfoService: RecordGameInfoService) {
        self.selectedTeam = BehaviorRelay(value: team)
        self.recordStorage = recordStorage
        self.gameInfoService = gameInfoService
        bind()
    }

    private func bind(){
        floatingButtonTapped
            .bind(to: navigateToCreate)
            .disposed(by: disposeBag)
    }
    
    func loadMergeData() {
        recordStorage.fetchRecords()
            .catchAndReturn([])
            .bind(to: recordList)
            .disposed(by: disposeBag)
    }

    
    func loadRecentGames() {
        Task {
            let teamId = self.selectedTeam.value.id
            let games = await gameInfoService.fetchGames(for: teamId)
            
            await MainActor.run {
                self.gameInfoResults.accept(games)
            }
        }
    }
}
