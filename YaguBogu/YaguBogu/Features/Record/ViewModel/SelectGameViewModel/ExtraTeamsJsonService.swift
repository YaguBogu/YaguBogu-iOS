import Foundation

final class ExtraTeamsJsonService {
    
    private let jsonLoader: JsonLoader
    
    init(jsonLoader: JsonLoader = JsonLoader()) {
        self.jsonLoader = jsonLoader
    }
    
    func loadExtraTeams() -> [TeamExtra] {
        if let decodedData: TeamExtraData = jsonLoader.load("ExtraTeamModel") {
            return decodedData.ExtraTeamModel
        } else {
            print("JSON 에러")
            return []
        }
    }
}
