import Foundation
import Alamofire

class DailyForecastLoader {
    
    // MARK: Singleton
    static let shared = DailyForecastLoader()
    // MARK: Base Variables
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    let parameters: Parameters = [
        "q": "Moscow",
        "appid": "5c6d5fcb81a6947c1287c884184862e0",
        "lang": "ru",
        "units": "metric"
    ]
    
    func fetchDailyData(completion: @escaping (_ data: Current?, _ status: Bool, _ message: String) -> Void) {
        AF.request(baseURL, parameters: parameters).response { response in
            guard let data = response.data else { return }
            do {
                let forecast = try JSONDecoder().decode(Current.self, from: data)
                completion(forecast, true, "")
            } catch {
                completion(nil, false, error.localizedDescription)
            }
        }
    }
}
