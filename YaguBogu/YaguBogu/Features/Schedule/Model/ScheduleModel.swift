import Foundation

struct ScheduleResponse: Codable {
    let response: [ScheduleItem]
}

struct ScheduleItem: Codable {
    let id: Int
    let date: String
    let status: Status
    let teams: Teams
    let scores: Scores?
    let time: String
    let timestamp: Int
    let timezone: String
}

struct Status: Codable {
    let short: String
}

struct Teams: Codable {
    let home: TeamDetail
    let away: TeamDetail
}

struct TeamDetail: Codable {
    let id: Int
    let name: String
}

struct Scores: Codable {
    let home: ScoreDetail
    let away: ScoreDetail
}

struct ScoreDetail: Codable {
    let total: Int?
}

// 앱 내부에서 사용할 자체 모델
struct Game: Identifiable {
    let id: Int
    let date: Date
    let status: GameStatus
    let time: String
    let awayTeamName: String
    let homeTeamName: String
    let result: GameResult?
    let stadiumName: String?
}

enum GameStatus {
    case finished
    case scheduled
}

struct GameResult {
    let homeTeamScore: Int
    let awayTeamScore: Int
}

extension ScheduleItem {
    func toGame(for selectedTeamID: Int)  -> Game? {
        // timestamp -> Date로 반환
        let gameDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // KST 시간으로 변한
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.string(from: gameDate)
        
        // 홈/원정 판별
        let myTeamIsHome = (teams.home.id == selectedTeamID)
        let homeTeamName = teams.home.name
        let awayTeamName = teams.away.name
        
        // 경기 상태
        let gameStatus: GameStatus = (status.short == "FT") ? .finished : .scheduled
        
        // 경기 결과
        var result: GameResult? = nil
        if let scores = scores,
           let homeTeamScore = scores.home.total,
           let awayTeamScore = scores.away.total,
           gameStatus == .finished {
            result = GameResult(homeTeamScore: homeTeamScore, awayTeamScore: awayTeamScore)
        }
        
        let stadiumName = StadiumManager.shared.stadiumName(for: homeTeamName)
        
        return Game(
            id: id,
            date: gameDate,
            status: gameStatus,
            time: timeString,
            awayTeamName: awayTeamName,
            homeTeamName: homeTeamName,
            result: result,
            stadiumName: stadiumName
        )
    }
}
