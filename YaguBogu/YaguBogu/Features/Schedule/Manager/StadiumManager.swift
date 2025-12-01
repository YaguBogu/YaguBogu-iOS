import Foundation

class StadiumManager {
    static let shared = StadiumManager()
    private var stadiums: [String: StadiumInfo] = [:] // teamId(팀 이름) -> StadiumInfo
    
    private init() {
        loadStadiums()
    }
    
    private func loadStadiums() {
        guard let url = Bundle.main.url(forResource: "ExtraTeamModel", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(TeamExtraData.self, from: data) else {
            print("JSON 불러오기 실패")
            return
        }
        
        response.ExtraTeamModel.forEach { team in
            if let lat = Double(team.latitude),
               let lon = Double(team.longtitude) {
                let info = StadiumInfo(
                    name: team.stadium,
                    city: team.city,
                    latitude: lat,
                    longitude: lon
                )
                stadiums[team.teamId] = info
            }
        }
    }
    
    func stadiumName(for teamId: String) -> String? {
        return stadiums[teamId]?.name
    }
}
