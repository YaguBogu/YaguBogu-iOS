import Foundation

struct StadiumWeather {
    let temperatureC: Double      // 섭씨 온도(C)
    let humidity: Int            // 습도 (%)
    let windSpeed: Double        // 풍속 (m/s)
    let precipitation: Double?   // 강수량 (1시간 기준으로 mm, 없을 때는 nil)
}

