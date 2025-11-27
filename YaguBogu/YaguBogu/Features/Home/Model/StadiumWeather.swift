import Foundation

struct StadiumWeather {
    let temperatureC: Double
    let humidity: Int
    let windSpeed: Double
    let precipitation: Double?
    let description: String
}

struct StadiumForecast {
    let dateTimeText: String      // "2025-11-27 09:00:00" 이런 문자열이 옴
    let temperatureC: Double
    let description: String       // "clear sky", "few clouds"
}

