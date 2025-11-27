import Foundation

struct WeatherResponse: Decodable {
    let weather: [WeatherInfo]
    let main: MainInfo
    let wind: WindInfo
    let rain: RainInfo?
}

struct WeatherInfo: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
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

