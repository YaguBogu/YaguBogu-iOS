import UIKit
import CoreLocation
import RxSwift
import RxRelay

class TeamViewModel {
    let teams = BehaviorRelay<[TeamInfo]>(value: [])
    private let jsonLoader = JsonLoader()
    
    func loadMergeData(){
        
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
                    let longitude = Double(extraInfo.longtitude) ?? 0.0
                    let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    
                    let newTeam = TeamInfo(
                        id: apiTeam.id,
                        name: apiTeam.name,
                        logoURL: URL(string: apiTeam.logo),
                        stadium: extraInfo.stadium,
                        city: extraInfo.city,
                        location: location,
                        defalutCharacter: extraInfo.defalutCharacter,
                        teamLogo: extraInfo.teamLogo
                    )
                    mergeList.append(newTeam)
                }
            }
            self.teams.accept(mergeList)
        }
        
        task.resume()
    }
}
