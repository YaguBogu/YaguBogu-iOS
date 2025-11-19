import Foundation
import CoreLocation

struct TeamInfo: Identifiable{
    //API
    let id: Int
    let name: String
    let logoURL: URL?
    //JSON
    let stadium: String
    let city: String
    let location: CLLocationCoordinate2D
    let defalutCharacter: String
    let teamLogo: String
}


// MARK: - Response
struct Response: Codable {
    let id: Int
    let name: String
    let logo: String
}
struct Team: Codable {
    let response: [Response]
}

struct TeamExtraData: Codable {
    let ExtraTeamModel: [TeamExtra]
}

struct TeamExtra: Codable {
    let teamId: String
    let stadium: String
    let city: String
    let latitude: String
    let longtitude: String
    let defalutCharacter: String
    let teamLogo: String
}
