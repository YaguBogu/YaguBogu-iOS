import Foundation
import RxSwift

protocol WeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) -> Single<StadiumWeather>
}

final class WeatherService: WeatherServiceProtocol {

    func fetchWeather(lat: Double, lon: Double) -> Single<StadiumWeather> {
        let apiKey = Secrets.$WeatherApiKey
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"

        return Single<StadiumWeather>.create { single in

            guard let url = URL(string: urlString) else {
                single(.failure(NSError(domain: "Invalid URL", code: 0)))
                return Disposables.create()
            }

            URLSession.shared.dataTask(with: url) { data, _, error in

                if let error = error {
                    single(.failure(error))
                    return
                }

                guard let data = data else {
                    single(.failure(NSError(domain: "No Data", code: 0)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    let weather = StadiumWeather(
                        temperatureC: decoded.main.temp,
                        humidity: decoded.main.humidity,
                        windSpeed: decoded.wind.speed,
                        precipitation: decoded.rain?.oneHour,
                        description: decoded.weather.first?.description ?? ""
                    )
                    single(.success(weather))
                } catch {
                    single(.failure(error))
                }

            }.resume()

            return Disposables.create()
        }
    }
}

