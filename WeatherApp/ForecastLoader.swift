import Foundation
import Alamofire

class ForecastLoader {
    
    // MARK: Singleton
    static let shared = ForecastLoader()
    // MARK: Base Variables
    let currentURL = "https://api.openweathermap.org/data/2.5/weather"
    let currentParameters: Parameters = [
        "q": "Moscow",
        "appid": "5c6d5fcb81a6947c1287c884184862e0",
        "lang": "ru",
        "units": "metric"
    ]
    
    let dailyURL = "https://api.openweathermap.org/data/2.5/onecall"
    let dailyParams: Parameters = [
        "lat": "55.751244",
        "lon": "37.618423",
        "exclude": "minutely,hourly",
        "appid": "5c6d5fcb81a6947c1287c884184862e0",
        "lang": "ru",
        "units": "metric"
    ]
    
    func fetchCurrentData(completion: @escaping (_ data: Current?, _ status: Bool, _ message: String) -> Void) {
        AF.request(currentURL, parameters: currentParameters).response { response in
            guard let data = response.data else { return }
            do {
                let forecast = try JSONDecoder().decode(Current.self, from: data)
                DispatchQueue.main.async {
                    completion(forecast, true, "")
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, false, error.localizedDescription)
                }
            }
        }
    }
    
    func fetchDailyData(completion: @escaping (_ data: [Daily]?, _ status: Bool, _ message: String) -> Void) {
        AF.request(dailyURL, parameters: dailyParams).response { response in
            guard let data = response.data else { return }
            do {
                let forecast = try JSONDecoder().decode(Weekly.self, from: data)
                DispatchQueue.main.async {
                    completion(forecast.daily, true, "")
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, false, error.localizedDescription)
                }
            }
        }
    }
}
