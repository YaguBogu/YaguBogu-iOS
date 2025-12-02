import Foundation
import CoreLocation

class TeamInfoManager {
    static let shared = TeamInfoManager()
    private var teams: [String: TeamInfo] = [:] // teamId(팀 이름) -> TeamInfo
    
    private init() {
        loadTeamInfo()
    }
    
    private func loadTeamInfo() {
        guard let url = Bundle.main.url(forResource: "ExtraTeamModel", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(TeamExtraData.self, from: data) else {
            print("JSON 불러오기 실패")
            return
        }
        
        response.ExtraTeamModel.forEach { team in
            if let lat = Double(team.latitude),
               let lon = Double(team.longitude) {
                let info = TeamInfo(
                    id: 0,
                    name: team.teamId,
                    stadium: team.stadium,
                    city: team.city,
                    location: CodableCoordinate(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)),
                    selectTeamLogo: team.selectTeamLogo,
                    defaultCharacter: team.defaultCharacter,
                    listCharacter: team.listCharacter
                )
                teams[team.teamId] = info
            }
        }
    }
    
    func stadiumName(for teamId: String) -> String? {
        return teams[teamId]?.stadium
    }
    
    func characterName(for teamId: String) -> String? {
        return teams[teamId]?.listCharacter
    }
}
