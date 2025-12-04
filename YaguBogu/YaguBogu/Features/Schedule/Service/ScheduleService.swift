import Foundation
import RxSwift

final class ScheduleService {
    
    func fetchSchedule(for teamID: Int, year: Int) -> Observable<[ScheduleItem]> {
        guard let url = URL(string: "https://v1.baseball.api-sports.io/games?team=\(teamID)&season=\(year)") else { return Observable.just([])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secrets.$BaseballApiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(ScheduleResponse.self, from: data).response
            }
            .catch { error in
                print("스케줄 API 에러:", error)
                return .just([])
            }
    }
}
