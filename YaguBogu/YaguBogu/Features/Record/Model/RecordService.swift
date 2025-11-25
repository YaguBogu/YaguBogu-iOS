import UIKit

final class RecordService{
    static let shared = RecordService()
    private init() {}
    
    func fetchGames(teamId: Int, date: Date) async -> [GameInfoResponse]{
        let dateString = dateToString(date)
        let year = Calendar.current.component(.year, from: date)
        
        guard let url = URL(string: "https://v1.baseball.api-sports.io/games?league=5&season=\(year)&team=\(teamId)&date=\(dateString)") else {return []}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(Secrets.$BaseballApiKey, forHTTPHeaderField: "x-rapidapi-key")
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let response = try decoder.decode(GameInfo.self, from: data)
            return response.response
        } catch {
            return []
        }
    }
    
    func dateToString(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
