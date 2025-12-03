import UIKit
import CoreLocation
import RxSwift
import RxRelay
import RxCocoa

final class TeamViewModel {
    
    let itemSelected = PublishRelay<IndexPath>()
    let confirmButtonTapped = PublishRelay<Void>()
    
    let teams = BehaviorRelay<[TeamInfo]>(value: [])
    let isConfirmButtonState = BehaviorRelay<Bool>(value: false)
    
    let showAlert = PublishSubject<TeamInfo>()
    
    let selectedIndexPath = BehaviorRelay<IndexPath?>(value: nil)

    private let jsonLoader = JsonLoader()
    private var disposeBag = DisposeBag()
    private let selectedTeamInfo = BehaviorRelay<TeamInfo?>(value: nil)
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    init() {
        bind()
    }
    
    private func bind() {
        itemSelected
            .bind(to: selectedIndexPath)
            .disposed(by: disposeBag)
            
        selectedIndexPath
            .map { $0 != nil }
            .bind(to: isConfirmButtonState)
            .disposed(by: disposeBag)
        
        confirmButtonTapped
            .withLatestFrom(selectedIndexPath)
            .compactMap { $0 }
            .map { [weak self] indexPath -> TeamInfo? in
                return self?.teams.value[indexPath.item]
            }
            .compactMap { $0 }
            .bind(to: showAlert)
            .disposed(by: disposeBag)
        
    
        }
    
    func loadMergeData(){
        isLoading.accept(true)
        
        guard let teamExtraData: TeamExtraData = self.jsonLoader.load("ExtraTeamModel") else {
            print("JSON 로딩 실패")
            return
        }
        let localTeams = teamExtraData.ExtraTeamModel
        
        
        let components = Calendar.current.dateComponents([.year], from: Date())
        guard let year = components.year else {
            return
        }
        guard let url = URL(string: "https://v1.baseball.api-sports.io/teams?league=5&season=\(year)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secrets.$BaseballApiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else { return }
            guard let decodeAPI = try? JSONDecoder().decode(Team.self, from: data) else {
                print("API 디코딩 실패")
                return
            }
            
            let apiTeams = decodeAPI.response
            
            var mergeList: [TeamInfo] = []
            
            for apiTeam in apiTeams {
                if let extraInfo = localTeams.first(where: {$0.teamId == apiTeam.name}) {
                    let latitude = Double(extraInfo.latitude) ?? 0.0
                    let longitude = Double(extraInfo.longitude) ?? 0.0
                    
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let codableLocation = CodableCoordinate(coordinate: coordinate)
                    
                    let newTeam = TeamInfo(
                        id: apiTeam.id,
                        name: apiTeam.name,
                        stadium: extraInfo.stadium,
                        city: extraInfo.city,
                        location: codableLocation,
                        selectTeamLogo: extraInfo.selectTeamLogo,
                        defaultCharacter: extraInfo.defaultCharacter,
                        address: extraInfo.address,
                        listCharacter: extraInfo.listCharacter
                    )
                    mergeList.append(newTeam)
                }
            }
            DispatchQueue.main.async{
                self.teams.accept(mergeList)
                self.isLoading.accept(false)
            }
        }
        
        task.resume()
    }
}
