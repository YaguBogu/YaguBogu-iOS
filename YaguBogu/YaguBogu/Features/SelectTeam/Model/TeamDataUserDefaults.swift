
import Foundation

final class TeamDataUserDefaults {
    
    static let shared = TeamDataUserDefaults()
    private init() {}
    
    
    private enum keys: String{
        case selectedTeam
    }
    
    func saveSelectedTeam(_ team: TeamInfo){
        do {
            let data = try JSONEncoder().encode(team)
            
            UserDefaults.standard.set(data, forKey: keys.selectedTeam.rawValue)
            print("팀 정보 저장 완료 \(team.name)")
        } catch {
            print("팀 정보 저장 실패")
        }
    }
    
    func getSelectedTeam() -> TeamInfo? {
            guard let data = UserDefaults.standard.data(forKey: keys.selectedTeam.rawValue) else {
                return nil
            }
            do {
                let team = try JSONDecoder().decode(TeamInfo.self, from: data)
                print("저장된 팀 정보 불러오기 성공")
                return team
            } catch {
                print("팀 정보 불러오기 실패")
                return nil
            }
        }
}
