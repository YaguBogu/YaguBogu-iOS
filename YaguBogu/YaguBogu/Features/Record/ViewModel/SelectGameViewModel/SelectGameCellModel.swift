import Foundation

struct SelectGameCellModel {
    let myTeamName: String
    let myTeamLogo: String
    
    let opposingTeamName: String
    let opposingTeamLogo: String
    
    let homeTeamName: String
    let awayTeamName: String
    
    let homeTeamLogo: String
    let awayTeamLogo: String
    
    let homeTeamID: Int
    let awayTeamID: Int
    
    let homeTeamScore: Int
    let awayTeamScore: Int
    
    let gameDate: String
    let score: String
    let stadium: String
    let isCancelled: Bool
}
