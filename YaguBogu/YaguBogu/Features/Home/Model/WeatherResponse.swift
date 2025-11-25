import Foundation

struct WeatherResponse: Decodable {
    let main: MainInfo
    let wind: WindInfo
    let rain: RainInfo?
}

struct MainInfo: Decodable {
    let temp: Double
    let humidity: Int
}

struct WindInfo: Decodable {
    let speed: Double
}

struct RainInfo: Decodable {
    let oneHour: Double?

    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}

