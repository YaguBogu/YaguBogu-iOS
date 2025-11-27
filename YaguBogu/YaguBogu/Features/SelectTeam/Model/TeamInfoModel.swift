import Foundation
import CoreLocation

struct CodableCoordinate: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

struct TeamInfo: Identifiable, Codable{
    //API
    let id: Int
    let name: String
    //JSON
    let stadium: String
    let city: String
    let location: CodableCoordinate
    let selectTeamLogo: String
    let defaultCharacter: String
}


// Response
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
    let selectTeamLogo: String
    let defaultCharacter: String
}
